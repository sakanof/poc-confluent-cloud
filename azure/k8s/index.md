# Kubernetes Kafka Clients – Usage Guide

This document explains how to use the Kubernetes manifests and Makefile to deploy, test, and manage Kafka client pods that connect to Confluent Cloud using Azure Workload Identity.

---

## 📁 Directory Overview

```bash
k8s/
├── Makefile                        # Targets to deploy and manage clients and identities
└── deployments/
    ├── service-account.yml         # Defines AKS service accounts with federated identity
    ├── kafka-clients.yml           # Kafka client pods: producer, consumer, topic owner
    └── client-properties.yml       # Kafka client configMaps with IAM properties
```

---

## 🧩 Makefile Targets

| Target                                    | Description                                                                 |
|-------------------------------------------|-----------------------------------------------------------------------------|
| `make setup-aks`                          | Authenticates kubectl to your AKS cluster                                   |
| `make create-namespace`                   | Creates the target namespace for clients                                    |
| `make delete-namespace`                   | Deletes the namespace and all resources                                     |
| `make create-service-accounts`            | Applies `service-account.yml` with federated identity annotations           |
| `make delete-service-accounts`            | Deletes the Kafka client service accounts                                   |
| `make get-service-accounts`               | Outputs service account YAMLs for verification                              |
| `make create-client-properties-configmap` | Creates configMaps with IAM/OAuth properties per client role                |
| `make deploy-kafka-clients`               | Deploys producer, consumer, and topic owner pods with preconfigured aliases |
| `make delete-kafka-clients`               | Deletes the Kafka client pods                                               |
| `make check-kafka-clients-identities`     | Checks if the workload identity is injected into pods                       |
| `make cp-confluent-dependency-to-pods`    | Copies required Confluent OAuth extension JARs to pods                      |
| `make run-kafka-producer`                 | Opens an interactive terminal in the producer pod                           |
| `make run-kafka-consumer`                 | Opens an interactive terminal in the consumer pod                           |
| `make run-kafka-topic-owner`              | Opens an interactive terminal in the topic owner pod                        |

---

## 🔐 Service Accounts and Identity

The `deployments/service-account.yml` defines two service accounts:
- `topic-owner-sa`: Used by the topic owner pod
- `read-sa`: Used by the consumer pod
- `write-sa`: Used by the producer pod

All are annotated with `azure.workload.identity/client-id` to bind a managed identity provisioned by Terraform.

These service accounts are essential for Azure Workload Identity to inject OAuth tokens at runtime.

All required configuration values such as identity pool IDs, application client ID, tenant ID, and bootstrap servers are dynamically retrieved from the output of their respective Terraform state files. This ensures consistency and eliminates hardcoding across environments.

---

## ⚙️ Kafka Client Configuration

The `deployments/client-properties.yml` file defines multiple `ConfigMap` objects, each mounting a `client_iam.properties` file. Each client uses a distinct identity pool:

- **Topic Owner:** Uses the topic-owner identity pool
- **Producer:** Uses the producer identity pool
- **Consumer:** Uses the consumer identity pool

All pods use OAuthBearer authentication with tokens retrieved via Azure's IMDS endpoint (`169.254.169.254`).

---

## 🛰 Kafka Client Pods

Defined in `deployments/kafka-clients.yml`, each pod:
- Is bound to a specific service account
- Mounts the correct client IAM configMap
- Sets `BOOTSTRAP_SERVER` and `KAFKA_OPTS`
- Defines shell aliases for convenient use of Kafka CLI tools

Clients include:
- `kafka-producer`: Alias to send messages via `kafka-console-producer.sh`
- `kafka-consumer`: Alias to consume messages from a topic using `kafka-console-consumer.sh`
- `kafka-topic-owner`: Alias to create topics using `kafka-topics.sh` with full access

⚠️ **Note:** Topic creation operations must be performed from the `kafka-topic-owner` pod. This enforces proper separation of privileges and aligns with the RBAC model enforced in Confluent Cloud.

Each pod sleeps for 1 hour to provide enough time for interactive testing.

---

## 📌 Notes

- The Confluent OAuth extensions JAR must be manually copied into each Kafka client pod using `make cp-confluent-dependency-to-pods`. This JAR can be built from the [Confluent OAuth Extensions source code](https://github.com/confluentinc/confluent-oauth-extensions). Before running the copy command, ensure you export the `CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH` environment variable pointing to the built JAR file.

- All Kubernetes manifests that include client configuration (`service-account.yml`, `client-properties.yml`, and `kafka-clients.yml`) rely on environment variable substitution. This substitution is handled automatically using `envsubst` during the `make` execution, ensuring that runtime values (e.g., identity pool IDs, cluster IDs) are properly injected.

- Before deploying the Kafka clients, ensure that the entire Terraform provisioning process has been successfully completed. This guarantees that all required Azure and Confluent Cloud resources — including managed identities, identity pools, and cluster endpoints — are available and their outputs can be referenced correctly by the Kubernetes deployment process.

---

## 🧪 Testing and Interaction

Follow this sequence to set up and test the Kafka clients, along with a brief description of what each target does:

1. **Configure kubectl to connect to your AKS cluster:**
   ```bash
   make setup-aks
   ```
   Retrieves the AKS kubeconfig and sets your kubectl context.

2. **Create the namespace where Kafka clients will be deployed:**
   ```bash
   make create-namespace
   ```
   Creates the Kubernetes namespace that will isolate the Kafka clients.

3. **Create the service accounts with federated identity binding:**
   ```bash
   make create-service-accounts
   ```
   Applies the `service-account.yml` manifest, creating service accounts annotated with the Azure managed identity client ID.

4. **Verify the service accounts were created correctly:**
   ```bash
   make get-service-accounts
   ```
   Retrieves and displays the YAML definition of the created service accounts to verify that the `azure.workload.identity/client-id` annotation is correctly injected.

5. **Create the client properties ConfigMaps:**
   ```bash
   make create-client-properties-configmap
   ```
   Generates the required ConfigMaps from `client-properties.yml`, with all cluster and identity information properly substituted.

6. **Deploy the Kafka client pods:**
   ```bash
   make deploy-kafka-clients
   ```
   Deploys the producer, consumer, and topic-owner pods with their respective configurations and service accounts.

7. **Verify that each pod has correctly injected Azure identity environment variables:**
   ```bash
   make check-kafka-clients-identities
   ```
   Inspects the running pods and ensures that Azure Workload Identity environment variables (e.g., `AZURE_TENANT_ID`, `AZURE_CLIENT_ID`) are properly injected.

8. **Copy the Confluent OAuth extension JAR into the client pods:**
   ```bash
   make cp-confluent-dependency-to-pods
   ```
   Manually copies the OAuth extension JAR into each pod's `/opt/kafka/libs` directory, enabling Kafka clients to use Azure Workload Identity tokens for OAuth authentication.

9. **Run the topic owner pod and create the Kafka topic:**
   ```bash
   make run-kafka-topic-owner
   create_topic
   ```
   Opens an interactive shell inside the topic-owner pod. You must then run the `create_topic` alias to create the Kafka topic. Topic creation must be executed from the topic-owner pod due to RBAC restrictions.

10. **Run the producer pod and produce messages:**
    ```bash
    make run-kafka-producer
    producer
    ```
    Opens an interactive shell inside the producer pod. Run the `producer` alias to produce messages to the Kafka topic.

11. **Run the consumer pod and consume messages:**
    ```bash
    make run-kafka-consumer
    consumer
    ```
    Opens an interactive shell inside the consumer pod. Run the `consumer` alias to consume messages from the Kafka topic.

This process simulates a full, authenticated production and consumption workflow over Confluent Cloud using Azure Workload Identity, while enforcing RBAC-based access through proper role and pool assignments.

---