terraform {
  backend "gcs" {
    bucket      = "portfolio-fennecfromsahara-bucket"
    prefix      = "terraform/state"
    credentials = "../../Project/analog-reef-399320-e5f4d0d5ea9a.json"
  }
}
