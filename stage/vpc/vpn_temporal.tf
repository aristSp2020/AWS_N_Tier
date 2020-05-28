resource "aws_vpn_gateway" "vpn_gateway_metrovacesa" {
  vpc_id = "${aws_vpc.VPC.id}"

  tags {
      Name ="VPN_Gateway_SAP_Dev"
  }
}

resource "aws_customer_gateway" "customer_gateway_metrovacesa" {
  bgp_asn    = 65000
  ip_address = "88.87.132.114"
  type       = "ipsec.1"

  tags {
      Name = "Router Metrovacesa"
  }
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway_metrovacesa.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway_metrovacesa.id}"
  type                = "ipsec.1"
  static_routes_only  = "false"

  tags {
      Name = "VPN_Deloitte"
  }
}
