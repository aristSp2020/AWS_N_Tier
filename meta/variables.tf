variable "region" {
  description = "Default Region"
  type        = string
  default     = "eu-west-1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

