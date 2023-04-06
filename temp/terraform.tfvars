db_settings = {
    db_subnet_group_name = "cognos_subnet_group"
    identifier           = "cognosdb1"
    db_subnet_group_ids  = ["subnet-0b75044eac6729066","subnet-08fb5a399c486aef8"]
    engine               = "sqlserver-se"
    engine_version       = "15.00.4236.7.v1"
    db_security_groups      = ["sg-0c7f1b5301ccc6681"]
    publicly_accessible  = false
    instance_class       = "db.m5.large"
    allocated_storage    = 50
    backup_retention_period = 7
    multi_az               = true
    storage_type         = "gp2"
    license_model        = "license-included"
    username             = "admin"
    password             = "Cognostest123"
}
        tags = {
            Name = "cognos-db"
            Provisoned = "Terraform"
        }


lb_settings = {
    name               = "test-lb-tf"
    internal           = true
    load_balancer_type = "application"
    security_groups    = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b"]#[aws_security_group.lb_sg.id]
    subnets            = ["subnet-0b75044eac6729066","subnet-08fb5a399c486aef8"]#[for subnet in aws_subnet.public : subnet.id]
    enable_deletion_protection = false
    tags                       = { Environment = "alpha" }
    tg_name                    = "alb-tg"
    tg_port                    = "80"
    tg_protocol                = "HTTP"
    lstn_port     = "80"
    lstn_protocol = "HTTP"
    vpc_id = "vpc-004c56055bf95453c"
}
role_name = "cognos-build-role"

gw_ec2_settings = {
    "server1" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge" 
        instance_profile            = "test_role" ##
        sg_name                     = ["test", "test1"]  ##
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "gateway"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-gateway-1"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"
        }
    }

    "server2" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "gateway"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-gateway-2"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"
        }
    }
}
app_ec2_settings = {
    "server1" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "app"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-app-1"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"
        }
    }

    "server2" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "app"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-app-2"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"
        }
    }
}

content_manager_ec2_settings = {
    "server1" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "content"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-content-1"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"
        }
    }

    "server2" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        associate_public_ip_address = false
        key_name                    = "dataserv-ux-brandonb"
        vpc_id                      = "vpc-004c56055bf95453c"
        vpc_security_groups         = ["sg-0c7f1b5301ccc6681","sg-006eae57954c5594b","sg-0ebb884ecde48caca","sg-0903f0cdf86a18aa3"]
        subnet_id                   = "subnet-08fb5a399c486aef8"
        # availability_zone           = "us-east-1c"
        root_block_volume_size      = 40
        userdata                    = "content"
        ebs_block_device = [
            {
            device_name = "/dev/sdb"
            volume_type = "gp3"
            volume_size = 50
            throughput  = 200
            encrypted   = true
            }
        ]
        tags = {
            Name = "cognos-content-2"
            Provisoned = "Terraform"
            "fdc:pp-start" = "0 5 * * *"
            "fdc:pp-stop"  = "0 18 * * *"

        }
    }
}
sg = {"sg1" =   {   name = "test"
                    description = "test description"
                    vpc_id  = "xxxxx"
                    ingress = { "rule1" = { description      = "TLS from VPC"
                                            from_port        = 443
                                            to_port          = 443
                                            protocol         = "tcp"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = []
                                    }
                                "rule2" = { description      = "TLS from VPC"
                                            from_port        = 80
                                            to_port          = 80
                                            protocol         = "tcp"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = []
                                        }
                    }

                    egress = { "rule1" = { description      = "TLS from VPC"
                                            from_port        = 0
                                            to_port          = 0
                                            protocol         = "-1"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = ["::/0"]
                                        }
                            }
                    tags = {}
                }
        "sg2" =   {   name = "test1"
                    description = "test description"
                    vpc_id  = "vpc-0271c459c930e8e54"
                    ingress = { "rule1" = { description      = "TLS from VPC"
                                            from_port        = 443
                                            to_port          = 443
                                            protocol         = "tcp"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = []
                                    }
                                "rule2" = { description      = "TLS from VPC"
                                            from_port        = 80
                                            to_port          = 80
                                            protocol         = "tcp"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = []
                                        }
                    }

                    egress = { "rule1" = { description      = "TLS from VPC"
                                            from_port        = 0
                                            to_port          = 0
                                            protocol         = "-1"
                                            cidr_blocks      = ["0.0.0.0/0"]
                                            ipv6_cidr_blocks = ["::/0"]
                                        }
                            }
                    tags = {}
                }
}
