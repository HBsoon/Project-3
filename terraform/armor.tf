resource "google_compute_security_policy" "policy" {
  name = var.armor


  rule {
    action   = "deny(403)"
    priority = "150"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["113.64.0.0/10","116.128.0.0/10","117.128.0.0/10","120.192.0.0/10","183.0.0.0/10","183.192.0.0/10","36.128.0.0/10","39.128.0.0/10","43.0.0.0/10","59.192.0.0/10"]
      }
    }
    description = "중국 국가 코드로 들어오는 것을 거부하는 규칙"
  }
  rule {
    action   = "deny(403)"
    priority = "200"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["118.235.41.34"]
      }
    }
    description = "테스트를 위한 휴대폰 IP 거부 규칙"
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}
 