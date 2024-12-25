#Terraform_data is replacement of terraform null_resource
resource "terraform_data" "cluster_data" {
  count = var.environment == "dev" || var.environment == "DEV" ? 3 : 0

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("LaptopKey.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh"
      #   "sudo apt update",
      #   "sudo apt install jq unzip -y",
      #   "sudo sed -i '/<h1>Welcome.*/a <h1>${var.vpc_name}-PublicServer-${count.index + 1}</h1>' /var/www/html/index.nginx-debian.html"

    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("LaptopKey.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  #This resouce will be recreated if there is a changein tag version.
  triggers_replace = element(aws_instance.public-servers.*.tags.Version, count.index)
  depends_on = [
    aws_instance.public-servers,
    null_resource.cluster
  ]
}