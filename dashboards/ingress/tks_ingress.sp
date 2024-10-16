dashboard "tks_ingress" {

  title         = "TKS Ingresses"
  documentation = file("./dashboards/ingress/docs/ingress.md")

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

    query = query.ing_list_table
  }
}

query "ing_list_table" {
  sql = <<-EOQ
    SELECT
      context_name AS "Cluster ID",
      name AS "Ingress Name",
      namespace as "Namespace",
      jsonb_array_elements(rules) ->> 'host' AS "Host/URL",
      jsonb_array_elements(
        jsonb_array_elements(rules) -> 'http' -> 'paths'
      ) -> 'backend' -> 'service' ->> 'name' AS "Service Name",
      jsonb_array_elements(
        jsonb_array_elements(rules) -> 'http' -> 'paths'
      ) ->> 'path' AS "Path", 
      COALESCE(load_balancer -> 0 ->> 'ip', load_balancer -> 0 ->> 'hostname') AS "External_IP/LB_Hostname"
    FROM
      kubernetes_ingress
  EOQ
}
