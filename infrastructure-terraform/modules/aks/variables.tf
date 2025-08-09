variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location for AKS"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "node_count" {
  description = "Node count for AKS cluster"
  type        = number
  default     = 1
}

variable "min_count" {
  description = "Minimum node count for autoscaling"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum node count for autoscaling"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "Kubernetes version to deploy"
  type        = string
  default     = "1.32.0"
}
