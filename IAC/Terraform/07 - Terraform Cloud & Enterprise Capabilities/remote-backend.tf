terraform {
  cloud {
    organization = "demo-jay-org"

    workspaces {
      name = "demo-repository"
    }
  }
}
