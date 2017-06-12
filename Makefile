plan:
	terraform get
	terraform plan

apply:
	terraform apply
	terraform output -module=web_server public_ip

destroy:
	terraform destroy
