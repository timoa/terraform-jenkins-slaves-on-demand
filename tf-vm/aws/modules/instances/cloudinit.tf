data "template_file" "init-script" {
  template = "${file("./scripts/init.tpl")}"
}

data "template_file" "efs-script" {
  template = "${file("scripts/efs.sh")}"
}

data "template_file" "jenkins-script" {
  template = "${file("scripts/jenkins.sh")}"
}

data "template_file" "nginx-script" {
  template = "${file("scripts/nginx.sh")}"
}

data "template_cloudinit_config" "cloudinit-jenkins-master" {

  gzip = false
  base64_encode = false

  # 1. Pre-configure the Jenkins master instance
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-script.rendered}"
  }

  # 2. Mount the EFS volume on the Jenkins master
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.efs-script.rendered}"
  }

  # 3. Install and configure Jenkins master
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins-script.rendered}"
  }

  # 4. Install and configure NGINX as reverse-proxy
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.nginx-script.rendered}"
  }

}
