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
  count  = var.create_droplet ? 1 : 0
  name   = var.droplet_name
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-24-04-x64"

  ssh_keys = [var.ssh_key_id]
  tags     = ["tradeport", "staging"]
}

# 3️⃣ Output IP from whichever was selected
output "droplet_ip" {
  value = var.create_droplet ? digitalocean_droplet.tradeport[0].ipv4_address : data.digitalocean_droplet.existing[0].ipv4_address
}
