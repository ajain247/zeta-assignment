variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the vpc"
}

variable "tenancy" {
  type        = string
  default     = "default"
  description = "Tenancy type for the vpc"
}

variable "name" {
  type        = string
  default     = "zeta-assignment"
  description = "Name of the project"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for the public subnets"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for the private subnets"
}

variable "availability_zones" {
  type        = list(any)
  description = "CIDR block for the public subnets"
}
