APPLICATION_NAMESPACE=confluent-cloud-azure
SERVICE_ACCOUNT_READ=read-sa
SERVICE_ACCOUNT_TOPIC_OWNER=topic-owner-sa
SERVICE_ACCOUNT_WRITE=write-sa

CLUSTER_ID						:= $(shell jq -r '.outputs.cluster_id.value' ../terraform/confluent/cluster/terraform.tfstate)
BOOTSTRAP_SERVERS				:= $(shell jq -r '.outputs.bootstrap_endpoint.value' ../terraform/confluent/cluster/terraform.tfstate)

TENANT_ID						:= $(shell jq -r '.outputs.tenant_id.value' ../terraform/azure/resource-group/terraform.tfstate)
APPLICATION_CLIENT_ID			:= $(shell jq -r '.outputs.client_id.value' ../terraform/azure/app-registration/terraform.tfstate)
MANAGED_IDENTITY_CLIENT_ID		:= $(shell jq -r '.outputs.client_id.value' ../terraform/azure/managed-identity/terraform.tfstate)
TOPIC_OWNER_IDENTITY_POOL_ID	:= $(shell jq -r '.outputs.id.value' ../terraform/confluent/identity-pool-topic-owner/terraform.tfstate)
PRODUCER_IDENTITY_POOL_ID		:= $(shell jq -r '.outputs.id.value' ../terraform/confluent/identity-pool-producer/terraform.tfstate)
CONSUMER_IDENTITY_POOL_ID		:= $(shell jq -r '.outputs.id.value' ../terraform/confluent/identity-pool-consumer/terraform.tfstate)

get-pods:
	kubectl get pods --namespace ${APPLICATION_NAMESPACE}

setup-aks:
	az aks get-credentials --resource-group poc-aks-dev --name aks-kafka-dev

create-namespace:
	kubectl create namespace ${APPLICATION_NAMESPACE}

delete-namespace:
	kubectl delete namespace ${APPLICATION_NAMESPACE}

create-service-accounts:
	APPLICATION_NAMESPACE=${APPLICATION_NAMESPACE}							\
	SERVICE_ACCOUNT_TOPIC_OWNER=${SERVICE_ACCOUNT_TOPIC_OWNER}				\
	SERVICE_ACCOUNT_READ=${SERVICE_ACCOUNT_READ}							\
	SERVICE_ACCOUNT_WRITE=${SERVICE_ACCOUNT_WRITE}							\
	MANAGED_IDENTITY_CLIENT_ID=${MANAGED_IDENTITY_CLIENT_ID}				\
		envsubst < ./deployments/service-account.yml | kubectl apply -f -

get-service-accounts:
	kubectl get sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_READ} -o yaml
	kubectl get sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_WRITE} -o yaml

delete-service-accounts:
	kubectl delete sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_READ}
	kubectl delete sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_WRITE}

create-client-properties-configmap:
	CLUSTER_ID=${CLUSTER_ID}												\
	TOPIC_OWNER_IDENTITY_POOL_ID=${TOPIC_OWNER_IDENTITY_POOL_ID}			\
	PRODUCER_IDENTITY_POOL_ID=${PRODUCER_IDENTITY_POOL_ID}					\
	CONSUMER_IDENTITY_POOL_ID=${CONSUMER_IDENTITY_POOL_ID}					\
	APPLICATION_CLIENT_ID=${APPLICATION_CLIENT_ID}							\
		envsubst < ./deployments/client-properties.yml | kubectl apply -f -

deploy-kafka-clients: create-client-properties-configmap
	APPLICATION_NAMESPACE=${APPLICATION_NAMESPACE}							\
	SERVICE_ACCOUNT_TOPIC_OWNER=${SERVICE_ACCOUNT_TOPIC_OWNER} 				\
	SERVICE_ACCOUNT_READ=${SERVICE_ACCOUNT_READ} 							\
	SERVICE_ACCOUNT_WRITE=${SERVICE_ACCOUNT_WRITE}							\
	BOOTSTRAP_SERVER=${BOOTSTRAP_SERVERS}									\
	APPLICATION_CLIENT_ID=${APPLICATION_CLIENT_ID}							\
		envsubst < ./deployments/kafka-clients.yml | kubectl apply -f -

delete-kafka-clients:
	kubectl delete pod --namespace ${APPLICATION_NAMESPACE} kafka-producer kafka-consumer kafka-topic-owner

check-kafka-clients-identities:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-producer -- env | grep AZURE
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-consumer -- env | grep AZURE

cp-confluent-dependency-to-pods:
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-producer:/opt/kafka/libs/
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-consumer:/opt/kafka/libs/
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-topic-owner:/opt/kafka/libs/

run-kafka-producer:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-producer -- bash

run-kafka-consumer:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-consumer -- bash

run-kafka-topic-owner:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-topic-owner -- bash
