module "sg" {
  for_each = var.sg
  source   = "../sg_module"

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
  ingress     = each.value.ingress
  egress      = each.value.egress
  tags        = each.value.tags
}

output "sg_name_to_id" {
  value = local.sg_name_to_id
}

module "roles" {
    source = "../iam_module"

    role_name = "test_role"
    policy_name = "test_policy"
    description = "Test policy"
    assume_role_policy = jsonencode({
                                    Version = "2012-10-17"
                                    Statement = [
                                    {
                                        Action = "sts:AssumeRole"
                                        Effect = "Allow"
                                        Sid    = ""
                                        Principal = {
                                        Service = "ec2.amazonaws.com"
                                        }
                                    },
                                    ]
                                })
    policy  =   jsonencode({
                        Version = "2012-10-17"
                        Statement = [
                        {
                            Action = [
                            "ec2:Describe*",
                            ]
                            Effect   = "Allow"
                            Resource = "*"
                        },
                        ]
                    })
}

locals {
  name_to_role_arn = {for i in module.roles: i.name => i.arn}
  sg_name_to_id = {for i in module.sg: i.sg.name => i.sg.id}
}

output "name_to_role_arn" {
    value = local.name_to_role_arn
}

locals {
  gw_ec2_settings = {for i,j in var.gw_ec2_settings: i => 
                                {ami = j.ami
                                 instance_type = j.instance_type
                                 instance_pofile = local.name_to_role_arn[j.instance_profile]
                                 associate_public_ip_address = j.associate_public_ip_address
                                 key_name = j.key_name
                                 vpc_id = j.vpc_id
                                 vpc_security_groups = concat(j.vpc_security_groups, [for i in j.sg_name: local.sg_name_to_id[i]]) ##
                                 subnet_id = j.subnet_id
                                 root_block_volume_size = j.root_block_volume_size
                                 userdata = j.userdata
                                 ebs_block_device = j.ebs_block_device
                                 tags = j.tags
                                 }
                    }
}

output "zzzz" {
    value = local.gw_ec2_settings
}