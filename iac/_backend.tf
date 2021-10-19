terraform {
  // The path where tf state is storeds
  backend "local" {
    path = "./terraform.tfstate"
  }
}
