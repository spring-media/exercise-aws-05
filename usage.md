This Terraform templates will create the VPC, subnets, security groups, route tables, internet gateway, ec2 web server.
When the stack is applied, it will return public IP address of web server.
The web server can only be connected on port 22(ssh) and port 80(http) from internet. Although the ssh port 22 must be open to connect from specific public IPs.

Usage instructions:
1. Create the key pair in aws or use existing keys. Just give the name and path of key pair file in terraform.tfvars. Te key pairs file must be on same server where this templates will be executed. Name file as test "test-key.pem:
2. In terraform.tfvars file, add the aws user credentials at aws_access_key, aws_secret_key.
3. region - define the region where your aws keys are and where you want to host the web server.
4. To create the stack just use the make commands.
-  a. Plan - make plan (Just to see what services will be created, will not make any actual changes  )
-  b. Create - make apply (will create the whole stack and return the web server public IP address to use for connecting web server)

Any queries can be discussed with Rohit Turambekar (rohit.turambekar@gmail.com).

