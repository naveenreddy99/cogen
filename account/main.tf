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

output "sg_id" {
  value = module.sg["sg1"].sg.id
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

output "role_arn" {
    value = module.roles.role.arn
}