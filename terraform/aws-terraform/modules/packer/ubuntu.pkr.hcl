packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.8"
    }
  }
}

  source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-20.04-a1vincent"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = ["099720109477"]
  }
  ssh_username  = "ubuntu"
}

build {
  name    = "ubuntu-20.04-a1vincent"
  sources = ["sources.amazon-ebs.ubuntu"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
    script = "script.sh"
    
  }
}

