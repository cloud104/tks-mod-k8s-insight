dashboard "tks_loadbalancer_ingress" {

  title         = "TKS Loadbalancer Ingresses"
  documentation = file("./dashboards/ingress/docs/lb_ingress.md")

  tags = merge(local.ingress_common_tags, {
    type     = "Report"
    category = "TKS"
  })

  container {
  }

  table {

    column "UID" {
      display = "none"
    }

    query = query.lb_list_table
  }
}

query "lb_list_table" {
  sql = <<-EOQ
    select
        k.context_name as "Cluster ID",
        k.name as "LB Name",
        k.namespace as "Namespace",
        l ->> 'ip' as "Load Balancer IP"
    from
        kubernetes_service as k,
        jsonb_array_elements(load_balancer_ingress) as l
    where
        k.type = 'LoadBalancer'
  EOQ
}
