init:
	terraform init

plan:
	terraform plan -out out.tfplan

apply:
	terraform apply out.tfplan
