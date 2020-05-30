###
resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = var.description
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = true

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.user_certificate_arn
  }

  connection_log_options {
    enabled = false
  }
}

resource "aws_ec2_client_vpn_network_association" "this" {
  count = length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = element(var.subnet_ids, count.index)
}

resource "aws_cloudformation_stack" "vpn_ingress" {
  name = "vpn-ingress-stack"

  parameters = {
    clientVpnEndpointId : aws_ec2_client_vpn_endpoint.this.id
    targetNetworkCidr : var.vpc_cidr_block
  }

  template_body = file("${path.module}/vpn-ingress-stack.json")
}
