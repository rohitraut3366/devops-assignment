resource "null_resource" "ansible_configuration" {
  depends_on = [
    module.ec2_instance
  ]
  count = module.ec2_instance.count
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "${module.ec2_instance.*.public_dns[0][count.index]}"
      user        = "ubuntu"
      private_key = file("ansible-cm/devops.pem")
    }
    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "echo -e 'database: \"${var.rds_initial_database_name}\" \ndatabase_user:  \"${var.rds_database_username}\" \ndatabase_user_password: \"${var.rds_database_user_password}\" \nhostname: \"${aws_db_instance.rds_instace.address}\"' > ansible-cm/database_config_variables;  cd ansible-cm; ansible-playbook setup.yml;"
  }
}