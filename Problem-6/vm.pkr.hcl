variable "ami_id" {
  type    = string
  default = "ami-0c1a7f89451184c8b"
}

variable "image_version" {
  type    = string
  default = "1"
}
variable "rds_initial_database_name" {
  description = "Database name"
  type        = string

}
variable "rds_database_username" {
  description = "Database user"
  type        = string
}

variable "rds_database_user_password" {
  description = "Database Address"
  type        = string
}

variable "rds_address" {
  description = "Database Address"
  type        = string
}

source "amazon-ebs" "wordpress" {
  ami_name      = "wordpress-${var.image_version}"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "${var.ami_id}"
  ssh_keypair_name = "devops"
  ssh_private_key_file = "./devops.pem"
  ssh_username  = "ubuntu"
  run_tags = {
    Name = "Wordpress_${var.image_version}"  
  }
  tags = {
    Name = "Wordpress-${var.image_version}"
  }
}

build {
  sources = ["source.amazon-ebs.wordpress"]

  provisioner "ansible" {
      playbook_file = "setup.yml"
      inventory_file = "./inventory/"
      use_proxy= false
      ansible_env_vars= [
        "ANSIBLE_CONFIG=./ansible.cfg" 
      ]
  }
}