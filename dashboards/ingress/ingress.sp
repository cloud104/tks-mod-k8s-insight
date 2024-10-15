locals {
  ingress_common_tags = {
    service = "TKS/Ingress"
  }
}

category "ingress" {
  title = "Ingress"
  color = local.ingress_color
  href  = "/kubernetes_insights.dashboard.ingress_detail?input.ingress_uid={{.properties.'UID' | @uri}}"
  icon  = "format_shapes"
}

query "ingress_count" {
  sql = <<-EOQ
    select
      count(*) as "Ingresses"
    from
      kubernetes_ingress
  EOQ
}
