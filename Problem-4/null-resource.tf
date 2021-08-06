resource "null_resource" "ansible_configuration" {
  depends_on = [
    module.ec2_instance,
    module.rds_mysql_instance
  ]
  count = var.instance_count
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = module.ec2_instance.*.public_dns[count.index][0]
      user        = "ubuntu"
      private_key = file("ansible-cm/devops.pem")
    }
    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "echo -e 'database: \"${module.rds_mysql_instance.rds_initial_database_name}\" \ndatabase_user:  \"${module.rds_mysql_instance.rds_database_username}\" \ndatabase_user_password: \"${module.rds_mysql_instance.rds_database_user_password}\" \nhostname: \"${module.rds_mysql_instance.rds_address}\"' > ansible-cm/database_config_variables;  cd ansible-cm; ansible-playbook setup.yml;"
  }
}