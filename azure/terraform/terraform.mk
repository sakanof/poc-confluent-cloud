OUTPUT_PLAN_FILENAME=plan.tfplan
TERRAFORM_CMD=terraform

# Use docker instead
# TERRAFORM_IMAGE=hashicorp/terraform:latest
# TERRAFORM_CMD=docker run -it \
# 		  -w "/terraform" \
# 		  -v ${PWD}:/terraform ${TERRAFORM_IMAGE}

.PHONY: all
all: init plan apply

.PHONY: init
init:
	${TERRAFORM_CMD} init

.PHONY: validate
validate:
	${TERRAFORM_CMD} validate

.PHONY: plan
plan: validate
	${TERRAFORM_CMD} plan -out=${OUTPUT_PLAN_FILENAME}

.PHONY: apply
apply: plan
	${TERRAFORM_CMD} apply ${OUTPUT_PLAN_FILENAME}

.PHONY: destroy
destroy:
	${TERRAFORM_CMD} destroy -auto-approve
