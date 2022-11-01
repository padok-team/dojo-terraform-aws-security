# Bootstrap

1. Apply bootstrap terraform
```bash
tf init
tf apply
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
