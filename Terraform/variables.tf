variable "aws_region" {
  description = "Set aws region"
  default     = "us-east-2"
}

variable "aws_profile" {
  description = "Set the aws cli profile to use"
  default     = "default"
}
variable "name_tag" {
  description = "Set the Name Tag used for filtering specific VPC and Security Groups"
  default     = "jerome-test"
}

variable "instance" {
  description = "Set Instance type e.g T3.medium"
  default     = "t2.micro"

}

variable "iam_role" {
  description = "IAM Role to be used"
  default     = "jtabiri"
}

variable "volume_type" {
  description = "The type of volume. Can be standard gp2 or io1 or sc1st1"
  default     = "standard"
}

variable "volume_size" {
  description = "size of the ebs volume needed"
  default     = "50"
}

variable "key_name" {
  description = "name given to the SSH keys"
  default     = "jerome-key"
}

variable "tags" {
  type = map(any)
  default = {
    Name = "jerome-test"
  }
}
