output vpc_id_prd {
  value = module.vpc["prd"].vpc_id
}

output "public_subnets_prd" {
  value = module.vpc["prd"].public_subnets
}

output "private_subnets_prd" {
  value = module.vpc["prd"].private_subnets
}

output vpc_id_dev {
  value = module.vpc["dev"].vpc_id
}

output "public_subnets_dev" {
  value = module.vpc["dev"].public_subnets
}

output "private_subnets_dev" {
  value = module.vpc["dev"].private_subnets
}
