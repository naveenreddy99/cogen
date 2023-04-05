module "iam_role" {
source = "../../modules/iam"
role_name = var.role_name
}

module "content_manager_tier_ec2" {
    source = "../../modules/ec2"

    for_each = var.content_manager_ec2_settings
    ec2_settings = each.value
    iam_instance_profile = module.iam_role.profile.name
}

module "lb" {
    source = "../../modules/lb"

    lb_settings = var.lb_settings
}

module "app_tier_ec2" {
    source = "../../modules/ec2"


    for_each = var.app_ec2_settings
    ec2_settings = each.value
    iam_instance_profile = module.iam_role.profile.name
}

module "gw_tier_ec2" {
    source = "../../modules/ec2"

    for_each = var.gw_ec2_settings

    ec2_settings = each.value
    iam_instance_profile = module.iam_role.profile.name
}

module "rds" {
    source = "../../modules/rds"


    db_settings = var.db_settings
}
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
                           "Version": "2012-10-17",
                           "Statement": [
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:*Object",
            "Resource": "arn:aws:s3:::businessanalytics-shared-s3/*"
        }
    ]
                    })
}
