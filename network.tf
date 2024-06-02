# resource "aws_vpc" "ntier_vpc" {
#     cidr_block = "10.10.0.0/16"
#     tags = {
#       Name = "ntier"
#     }

# }

resource "aws_vpc" "ntier_vpc" {
  cidr_block = var.vpc_network_cidr
  tags = {
    Name = local.name # This is from internals.tf
  }

}


resource "aws_subnet" "subnet1" {
  count      = length(var.subnets_names)
  vpc_id     = aws_vpc.ntier_vpc.id
  cidr_block = cidrsubnet(var.vpc_network_cidr, 8, count.index)
  #cidr_block = (var.subnets_cidr_range, count.index)
  tags = {
    Name = var.subnets_names[count.index]
  }
  depends_on = [
    aws_vpc.ntier_vpc
  ]
}


# resource "aws_subnet" "subnet1" {
#     vpc_id = aws_vpc.ntier_vpc.id
#     cidr_block = "10.10.0.0/24"

#     tags = {
#       Name = "web"
#     }

# }

data "aws_route_table" "default" { #This routetable will fetch us only one id. right now in our network we have only one route table
  vpc_id = aws_vpc.ntier_vpc.id

  depends_on = [
    aws_vpc.ntier_vpc
  ]

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ntier_vpc.id
  tags = {
    Name = "ntier igw"
  }

  depends_on = [
    aws_vpc.ntier_vpc
  ]

}

resource "aws_route" "igwroute" {
  route_table_id         = data.aws_route_table.default.id #"rtb-0d7627778eec0cc2f" this we got once we run terraform apply 
  destination_cidr_block = local.anywhere                  # Here we go to internals.tf and then there written in locals { anaywhere = "0.0.0.0/0"} means from any ipaddress
  gateway_id             = aws_internet_gateway.igw.id     # once we written all of this then go to outputs.tf and then put the script in comments as we dont need further as we already got the routetable id
  depends_on = [
    aws_vpc.ntier_vpc,
    aws_internet_gateway.igw

  ]


}