gw_ec2_settings = {
    "server1" = {
        ami                         = "ami-021d2fa9809e1e393"
        instance_type               = "t2.2xlarge"
        instance_profile            = "test_role"
        sg_name                     = ["test", "test1"]
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
}

sg = {"sg1" =   {   name = "test"
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
