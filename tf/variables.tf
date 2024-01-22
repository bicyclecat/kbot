variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-a"
  description = "GCP region to use"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "Github repo owner"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "Github access token"
  sensitive   = true
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "flux-cluster"
  description = "Cluster name"
}

variable "GKE_DELETION_PROTECTION" {
  type        = bool
  default     = false
  description = "Cluster deletion protection. False allows Terraform to remove cluster"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 1
  description = "GKE nodes number"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "e2-small"
  description = "GKE Machine type"
}

variable "GKE_DISK_TYPE" {
  type        = string
  default     = "pd-standard"
  description = "GKE Machine disk type"
}

variable "GKE_DISK_SIZE_GB" {
  type        = string
  default     = 10
  description = "GKE Machine disk size in GB"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux repository name"
}
