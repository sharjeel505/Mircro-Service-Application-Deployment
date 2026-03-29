variable "cluster_name" {
  type        = string
  description = "cluster_name"
  default     = "emumba-mircoservice-app"
}

variable "cluster_image" {
  type        = string
  description = "Cluster iamge"
  default     = "rancher/k3s:v1.27.4-k3s1"
}


variable "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  type        = string
  default     = "13.60.86.35"  # replace with your EC2 public IP
}

#variable "helm_release" {
#  description = "Helm realease deployment"
#  type = map(object({
#    repository       = string
#    chart            = string
#    namespace        = optional(string, "default")
#    values           = optional(list(string), [])
#    create_namespace = optional(bool, true)
#    version          = optional(string)
#  }))
#}
