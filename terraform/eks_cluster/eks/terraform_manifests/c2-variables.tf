variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "business_division" {
  description = "Business Division"
  type        = string
  default     = "retail"
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

# EKS Cluster Configuration
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "reatil-cluster"
}

variable "cluster_version" {
  type        = string
  default     = null
  description = "K8s minor version to use for EKS cluster"
}

variable "cluster_service_ipv4_cidr" {
  description = "Service CIDR range for k8s services"
  type        = string
  default     = null
}

variable "cluster_endpoint_public_access" {
  description = "Whether to enable private access to EKS control plane endpoint"
  type        = bool
  default     = true # must make it false(use private access using bastion), to practice purpose keeping it true 
}

variable "cluster_endpoint_private_access" {
  description = "Whether to enable private access to EKS control plane endpoint"
  type        = bool
  default     = false # must make it true(use private access using bastion), to practice purpose keeping it false 
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks allowed to access public EKS endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EKS Node Group Configuration

variable "node_instance_types" {
  description = "List of EC2 instance types for node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "Instance capacity type: On_DEMAND or spot"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}
