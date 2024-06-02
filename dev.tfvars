vpc_network_cidr = "10.10.0.0/16"

#(we dont need "subnets_cidr_range" below anymore as we used "cidrsubnet(prefix, newbits, netnum)" 
#in network.tf so we commented as below for subnets_cidr_range)

#subnets_cidr_range = "10.10.%g.0/24"

subnets_names = ["web1", "web2", "app1", "app2", "db1", "db2", "db3", "db4"]

websg_config = {
  name        = "websg"
  description = "This is web security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    to_port    = 80
    from_port  = 80

    },
    {
      type       = "ingress"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
      to_port    = 22
      from_port  = 22
    },
    {
      type       = "egress"
      protocol   = -1
      cidr_block = "0.0.0.0/0"
      to_port    = 65535
      from_port  = 0
  }]
}

appsg_config = {
  name        = "appsg"
  description = "This is app security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    to_port    = 22
    from_port  = 22

    },
    {
      type       = "ingress"
      protocol   = "tcp"
      cidr_block = "10.10.0.0/16"
      to_port    = 8080
      from_port  = 8080
    },
    {
      type       = "egress"
      protocol   = -1
      cidr_block = "0.0.0.0/0"
      to_port    = 65535
      from_port  = 0
  }]
}

dbsg_config = {
  name        = "dbsg"
  description = "This is db security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    cidr_block = "10.10.0.0/16"
    to_port    = 3306
    from_port  = 3306

    },
    {
      type       = "egress"
      protocol   = -1
      cidr_block = "0.0.0.0/0"
      to_port    = 65535
      from_port  = 0
  }]
}


