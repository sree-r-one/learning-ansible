provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "tradeport" {
  name   = "tradeport-staging"
  region = "sgp1"                     # Change region if needed
  size   = "s-1vcpu-1gb"              # Cheapest droplet (~$4–6/mo)
  image  = "docker-20-04"             # Ubuntu with Docker pre-installed

  ssh_keys = [var.ssh_key_id]         # Your public key must be added via DO panel

  tags = ["tradeport", "staging"]
}

output "droplet_ip" {
  value = digitalocean_droplet.tradeport.ipv4_address
}
