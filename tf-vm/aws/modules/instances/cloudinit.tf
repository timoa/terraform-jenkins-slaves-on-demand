data "template_file" "init-script" {
  template = "${file("./scripts/init.cfg")}"
}

data "template_cloudinit_config" "cloudinit-jenkins-master" {

  gzip = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-script.rendered}"
  }

}
