# Terraform Usage Guide

This document explains how to use the `Makefile` system to orchestrate the provisioning and teardown of all Azure and Confluent Cloud resources used in this proof of concept.

---

## 📁 Files Overview

```bash
terraform/
├── Makefile          # Main entry point to control provisioning order
├── modules.mk        # Defines logic to iterate over each resource
├── terraform.mk      # Common Terraform command wrappers
```

---

## 🧱 Structure and Purpose

### `terraform.mk`

Defines generic Terraform operations:
- `init`: initializes Terraform backend and providers
- `validate`: runs `terraform validate`
- `plan`: creates a plan and saves it to `plan.tfplan`
- `apply`: applies the saved plan
- `destroy`: destroys all infrastructure

### `modules.mk`

Executes Make targets (e.g. `init`, `plan`, `apply`, `destroy`) across all resource subdirectories listed in the `MODULES` variable.
- Ensures order of operations
- Destroys in reverse order to respect dependencies

### `Makefile`

Includes the `modules.mk` and defines the `MODULES` list in the correct provisioning order.

---

## ⚙️ Make Targets

From the current directory, you can run:

| Target        | Description                                           |
|---------------|-------------------------------------------------------|
| `make init`   | Runs `terraform init` in all resource directories     |
| `make plan`   | Runs `terraform plan` in all resource directories     |
| `make apply`  | Runs `terraform apply` sequentially in order         |
| `make destroy`| Runs `terraform destroy` in reverse order            |

---

## 📌 Provisioning Order

The order of provisioning is defined in the `MODULES` variable inside the root `Makefile`. This ensures dependencies (e.g., network before AKS, identity before OIDC) are respected.

Example:
```makefile
MODULES = azure/resource-group								\
		  azure/key-vault									\
		  azure/key-vault-key								\
		  confluent/byok									\
		  azure/vpc											\
		  confluent/environment								\
		  confluent/network									\
		  confluent/private-link							\
		  azure/private-link								\
		  confluent/cluster									\
		  azure/aks											\
		  azure/app-registration 							\
		  azure/managed-identity							\
		  azure/federated-managed-identity					\
		  confluent/identity-provider						\
		  confluent/identity-pool-topic-owner				\
		  confluent/identity-pool-topic-owner-permission	\
		  confluent/identity-pool-producer					\
		  confluent/identity-pool-producer-permission		\
		  confluent/identity-pool-consumer					\
		  confluent/identity-pool-consumer-permission
```

---

## 🌍 Required Environment Variables

Before running any Make targets, the following environment variables must be exported:

```bash
export TERRAFORM_DIR=$PWD/terraform
export TF_VAR_azure_subscription_id=<your-subscription-id>
export TF_VAR_confluent_api_key=<your-confluent-api-key>
export TF_VAR_confluent_api_secret=<your-confluent-api-secret>
```

### Explanation:

- `TERRAFORM_DIR` — Path to the root directory where the Makefiles and Terraform configurations are located. Used in includes like `include ${TERRAFORM_DIR}/modules.mk`.
- `TF_VAR_azure_subscription_id` — Injected into Terraform as the Azure subscription ID required by Azure providers.
- `TF_VAR_confluent_api_key` — Confluent Cloud API key passed to Terraform for authenticating API calls.
- `TF_VAR_confluent_api_secret` — Confluent Cloud API secret used together with the API key.

These variables are critical for authenticating with cloud providers and parameterizing reusable modules.

---

## ✅ Tips

- You must run `make init` at least once per directory to initialize Terraform.
- Ensure you are authenticated to Azure and Confluent before applying.
- Use `make destroy` to tear down everything cleanly.

---

## 📚 Next Steps

Refer to the documentation in each subdirectory (e.g. `azure/aks/`, `confluent/cluster/`) for specific configuration inputs and outputs.

This Makefile structure ensures consistent, repeatable provisioning and teardown across a multi-layered infrastructure-as-code project.

---