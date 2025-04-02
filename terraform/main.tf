terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# 1️⃣ Data block to use existing droplet (if create_droplet is false)
data "digitalocean_droplet" "existing" {
  count = var.create_droplet ? 0 : 1
  name  = var.droplet_name
}

# 2️⃣ Resource block to create new droplet (if create_droplet is true)
resource "digitalocean_droplet" "tradeport" {
  count    = var.create_droplet ? 1 : 0
  name     = var.droplet_name
  region   = var.region
  size     = var.droplet_size
  image    = var.droplet_image
  ssh_keys = [var.ssh_key_id]
  tags     = ["tradeport", "staging"]

  # Ensure proper SSH/firewall access
  provisioner "remote-exec" {
    inline = ["echo 'Droplet is ready!'"]
    
    connection {
      type        = "ssh"
      user        = "root"
      host        = self.ipv4_address
      private_key = var.ssh_private_key_content != "" ? var.ssh_private_key_content : file(var.ssh_private_key_path)
    }
  }
}

# 3️⃣ Output IP from whichever was selected
output "droplet_ip" {
  value = var.create_droplet ? digitalocean_droplet.tradeport[0].ipv4_address : data.digitalocean_droplet.existing[0].ipv4_address
}
