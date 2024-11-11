locals {
  versions_common_tags = {
    service = "TKS/Versions"
  }
}

dashboard "tks_versions" {

    title = "TKS Versions"
    documentation = file("./dashboards/versions/docs/versions.md")

    tags = merge(local.versions_common_tags, {
        type = "Report"
        category = "TKS"        
    })

    container{
    }

    table {
        query = query.versions
    }
}


query "versions" {
    sql = <<-EOQ
      SELECT
        SPLIT_PART(sp_connection_name, '_', 3) AS "Cluster ID",
        labels ->> 'tks-version' AS "TKS Version ",
        node_info ->> 'kubeletVersion' AS "K8S Version",
        node_info ->> 'osImage' AS "OS Image"
      FROM
        kubernetes_node
      WHERE
        labels ? 'node-role.kubernetes.io/control-plane'
        OR labels ? 'node-role.kubernetes.io/master'
        OR name LIKE '%master%'
        OR name LIKE '%control%'
        OR name LIKE '%apiserver%'
    EOQ
}