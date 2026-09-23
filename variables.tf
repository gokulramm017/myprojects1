variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "terraform-app-server"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
