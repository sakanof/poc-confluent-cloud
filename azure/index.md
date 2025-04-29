# Confluent Cloud on Azure – Proof of Concept (with Resource Comments)

This project is a **proof of concept (PoC)** designed to validate the integration between **Azure Kubernetes Service (AKS)** and **Confluent Cloud**, leveraging modern Azure-native authentication and networking capabilities. The architecture demonstrates secure Kafka client access from AKS to Confluent Cloud using:

- Bring Your Own Key (**BYOK**) integration with Azure Key Vault
- Secure and private network access via **Azure Private Link**
- Azure **Federated Workload Identity** with OpenID Connect (OIDC) integration
- Role-based access control (RBAC) in Confluent Cloud, granting:
  - `ResourceOwner` role to Kafka topic owner service accounts, which can be used to create and manage the topic.
  - `DeveloperWrite` role to Kafka producer service accounts
  - `DeveloperRead` role to Kafka consumer service accounts

It also employs **modular Terraform** configurations and **Makefiles** to automate both infrastructure provisioning and Kubernetes client deployments.

---

## 🗓 Project Goals

- Provision a secure and isolated AKS cluster on Azure.
- Integrate Confluent Cloud with Azure services: Key Vault, Private Link, Azure AD.
- Enable Kafka clients in AKS to authenticate using federated Azure Workload Identity.
- Authorize clients in Confluent Cloud using RBAC roles (`DeveloperRead`, `DeveloperWrite`).
- Structure infrastructure as reusable and maintainable Terraform modules.
- Deploy Kafka producer/consumer clients on AKS using Kubernetes manifests.
- Simplify operations with consistent `Makefile` targets for each resource.

---

## 📁 Directory Structure (with Comments)

```bash
.
├── k8s/                                            # Kubernetes client deployment layer
│   ├── Makefile                                    # Helper for deploying and cleaning up client resources
│   └── deployments/
│       ├── service-account.yml                     # Defines the federated identity service account in AKS
│       ├── kafka-clients.yml                       # Kafka client pods (producer and consumer)
│       └── client-properties.yml                   # Kafka config map (e.g., bootstrap servers, SASL config)
├── terraform/                                      # Infrastructure provisioning layer (Azure + Confluent)
│   ├── Makefile                                    # Global Makefile orchestrating provisioning order
│   ├── terraform.mk                                # Common Terraform CLI commands (init, plan, apply)
│   ├── modules.mk                                  # Executes Make targets across resource directories
│   ├── azure/                                      # Azure-specific resources (each with its own Makefile)
│   │   ├── resource-group/                         # Creates the Azure resource group
│   │   ├── vpc/                                    # Virtual network and subnet setup
│   │   ├── private-link/                           # Private endpoint to Confluent Cloud network
│   │   ├── aks/                                    # Azure Kubernetes Service (OIDC enabled)
│   │   ├── key-vault/                              # Azure Key Vault instance (for BYOK)
│   │   ├── key-vault-key/                          # Customer-managed key (CMK) for BYOK
│   │   ├── managed-identity/                       # User-assigned managed identity for federation
│   │   ├── federated-managed-identity/             # Links K8s OIDC to managed identity
│   │   └── app-registration/                       # Azure AD app registration for Confluent OIDC integration
│   ├── confluent/                                  # Confluent Cloud-specific resources (each with its own Makefile)
│   │   ├── environment/                            # Logical environment in Confluent Cloud
│   │   ├── network/                                # Confluent network configuration (for Private Link)
│   │   ├── private-link/                           # Approves Azure Private Link on Confluent side
│   │   ├── cluster/                                # Kafka cluster provisioning
│   │   ├── byok/                                   # Enables BYOK using Azure Key Vault key
│   │   ├── identity-provider/                      # Configures OIDC provider using Azure AD
│   │   ├── identity-pool-topic-owner/              # Identity pool for topic owners
│   │   ├── identity-pool-topic-owner-permission/   # Grants full topic access to owners
│   │   ├── identity-pool-producer/                 # Identity pool for producer service accounts
│   │   ├── identity-pool-producer-permission/      # Grants DeveloperWrite to producers
│   │   ├── identity-pool-consumer/                 # Identity pool for consumer service accounts
│   │   └── identity-pool-consumer-permission/      # Grants DeveloperRead to consumers
│   └── modules/                                    # Reusable Terraform modules
│       ├── azure/
│       │   ├── resource-group/                     # Module for creating an Azure resource group
│       │   ├── vpc/                                # Module for creating a virtual network
│       │   ├── private-link/                       # Module for Azure-side Private Link
│       │   ├── aks/                                # Module for AKS provisioning
│       │   ├── key-vault/                          # Module for Key Vault
│       │   ├── key-vault-key/                      # Module for BYOK-compatible CMK
│       │   ├── managed-identity/                   # Module for managed identity
│       │   ├── federated-managed-identity/         # Module for federated credential setup
│       │   └── app-registration/                   # Module for AAD app registration
│       └── confluent/
│           ├── environment/                        # Module for Confluent environment
│           ├── network/                            # Module for Confluent network
│           ├── private-link/                       # Module for Confluent-side Private Link
│           ├── cluster/                            # Module for Kafka cluster provisioning
│           ├── byok/                               # Module for BYOK setup
│           ├── identity-provider/                  # Module for OIDC provider setup
│           ├── identity-pool/                      # Module for defining identity pools
│           └── identity-pool-permission/           # Module for RBAC role binding
```

---

### Kubernetes Configuration (`./k8s`)

Kubernetes manifests to deploy and configure Kafka clients and supporting tools.
```
./k8s/deployments/service-account.yml       # AKS workload identity service account
./k8s/deployments/kafka-clients.yml         # Kafka producer and consumer pods
./k8s/deployments/client-properties.yml     # Kafka client configuration (mountable as configmap)
```

### Terraform Modules (`./terraform/modules`)

Reusable infrastructure modules, split by provider and purpose.

#### Azure Modules (`./terraform/modules/azure`)
```
resource-group/             # Creates the Azure resource group
vpc/                        # Provisions the VNet and subnets
aks/                        # Provisions the AKS cluster
key-vault/                  # Provisions Azure Key Vault
key-vault-key/              # Provisions customer-managed key for BYOK
app-registration/           # Creates an Azure AD app for federation
managed-identity/           # Creates a user-assigned managed identity
federated-managed-identity/ # Configures federated credential for AKS OIDC
```

#### Confluent Cloud Modules (`./terraform/modules/confluent`)
```
environment/                      # Creates the Confluent environment
network/                          # Configures the Confluent network
private-link/                     # Sets up Azure Private Link access
cluster/                          # Provisions a Kafka cluster
byok/                             # BYOK setup and linkage to Azure Key Vault
identity-provider/                # Registers Azure AD as an OIDC provider
identity-pool/                    # Defines the identity pool with claim filters
identity-pool-permission/         # Generic permissions for identity pool access
```

---

### Terraform Use Cases (`./terraform`)

Deployment wrappers around the modules, grouped by cloud.

#### Azure Deployment (`./terraform/azure`)
```
resource-group/
vpc/
private-link/
aks/
key-vault/
key-vault-key/
app-registration/
managed-identity/
federated-managed-identity/
```

#### Confluent Cloud Deployment (`./terraform/confluent`)
```
environment/
network/
cluster/
private-link/
byok/
identity-provider/
identity-pool-consumer/
identity-pool-consumer-permission/
identity-pool-producer/
identity-pool-producer-permission/
identity-pool-topic-owner/
identity-pool-topic-owner-permission/
```

---

## 🔗 Next Steps

Detailed documentation is available inside each module and deployment directory. This structure allows you to independently evolve Azure and Confluent Cloud infrastructure, while maintaining clear separation of concerns.

---