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
