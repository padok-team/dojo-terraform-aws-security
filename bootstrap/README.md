# Bootstrap

1. Create an AWS account
2. Configure an AWS profile

3. Apply bootstrap terraform
```bash
tf init
tf apply -var=aws_profile=<your_profile>
```

4. Create `.tfvars` files using terraform output
```bash
sed \
"s/<ENV>/\"prd\"/g; \
s/<VPC_ID>/$(tf output -json vpc_id_prd)/g; \
s/<PUBLIC_SUBNETS>/$(tf output -json public_subnets_prd)/g; \
s/<PRIVATE_SUBNETS>/$(tf output -json private_subnets_prd)/g" \
env.tfvars.tpl > ../iac/prd.tfvars

sed \
"s/<ENV>/\"dev\"/g; \
s/<VPC_ID>/$(tf output -json vpc_id_dev)/g; \
s/<PUBLIC_SUBNETS>/$(tf output -json public_subnets_dev)/g; \
s/<PRIVATE_SUBNETS>/$(tf output -json private_subnets_dev)/g" \
env.tfvars.tpl > ../iac/dev.tfvars
```

5. Retrieve access and secret keys for students
```bash
tf output eleve_access_key
tf output eleve_secret_key
```
