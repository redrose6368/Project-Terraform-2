variable "vpc-cidr" {
  type        = string
  description = "name of vpc cidr"
  default     = "10.0.0.0/16"

}
variable "prod-public-sub1-cidr" {
  type        = string
  description = "name of public subnet 1 cidr"
  default     = "10.0.1.0/24"

}

variable "prod-public-sub2-cidr" {
  type        = string
  description = "name of public subnet 2 cidr"
  default     = "10.0.2.0/24"

}
variable "prod-public-sub3-cidr" {
  type        = string
  description = "name of public subnet 1 cidr"
  default     = "10.0.3.0/24"

}
variable "prod-priv-sub1-cidr" {
  type        = string
  description = "name of private subnet 1 cidr"
  default     = "10.0.4.0/24"

}

variable "prod-priv-sub2-cidr" {
  type        = string
  description = "name of private subnet 2 cidr"
  default     = "10.0.5.0/24"

}

variable "region" {
  type        = string
  description = "name of region"
  default     = "eu-west-1"

}