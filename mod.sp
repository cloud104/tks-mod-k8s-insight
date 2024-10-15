mod "k8s_insights" {
  # Hub metadata
  title         = "K8S Insights"
  description   = "Insights for TKS Clusters"
  color         = "#0089D6"
  # documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/kubernetes-insights.svg"
  categories    = ["kubernetes", "dashboard", "private", "tks"]

  opengraph {
    title       = "TKS Mod for K8S Clusters Insights"
    description = "Dashboards and reports for our TKS Clusters."
    image       = "/images/mods/turbot/kubernetes-insights-social-graphic.png"
  }

  require {
    plugin "kubernetes" {
      min_version = "0.15.0"
    }
  }
}
