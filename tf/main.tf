terraform {
  backend "gcs" {
    bucket  = "kbot-moni-tf-flux-tfstate"
    prefix  = "terraform/state"
  }
}

module "github_repository" {
  source                   = "github.com/bicyclecat/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "google_gke_cluster" {
  source = "github.com/bicyclecat/tf-google-gke-cluster"
  google_region       = var.GOOGLE_REGION
  google_project      = var.GOOGLE_PROJECT
  gke_cluster_name    = var.GKE_CLUSTER_NAME
  deletion_protection = var.GKE_DELETION_PROTECTION
  num_nodes           = var.GKE_NUM_NODES
  machine_type        = var.GKE_MACHINE_TYPE
  disk_type           = var.GKE_DISK_TYPE
  disk_size_gb        = var.GKE_DISK_SIZE_GB
}

module "flux_bootstrap" {
  source            = "github.com/bicyclecat/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.google_gke_cluster.cluster_data.kubeconfig
  github_token      = var.GITHUB_TOKEN
}

module "tls_private_key" {
  source    = "github.com/bicyclecat/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

module "gke-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name                = "kustomize-controller"
  namespace           = module.flux_bootstrap.flux_bootstrap_data.flux_system_namespace
  project_id          = var.GOOGLE_PROJECT
  cluster_name        = module.google_gke_cluster.cluster_data.cluster_name
  location            = var.GOOGLE_REGION
  annotate_k8s_sa     = true
  roles               = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}

module "kms" {
  source              = "github.com/terraform-google-modules/terraform-google-kms"
  project_id          = var.GOOGLE_PROJECT
  keyring             = "sops-flux"
  location            = "global"
  keys                = ["sops-key-flux"]
  prevent_destroy     = false
}


output "kubepath" {
  value = module.google_gke_cluster.cluster_data.kubeconfig
}