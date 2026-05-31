# Self-hosted-VPN-Server
A secure, self-hosted WireGuard VPN gateway deployed on a Raspberry Pi featuring automated Dynamic DNS and optimized full-tunnel network routing.

# Self-Hosted WireGuard VPN Gateway (PiVPN + DuckDNS Setup)

A secure, self-hosted, full-tunnel WireGuard VPN server deployed on a Raspberry Pi infrastructure. This project demonstrates practical competencies in network security engineering, firewall routing, cryptographic peer-to-peer architecture, and automated dynamic DNS translation.

## 🛠️ Architectural Overview

This deployment establishes a secure, encrypted UDP tunnel from remote endpoints (iOS, macOS) back to a residential local area network (LAN). Traffic is fully encapsulated using WireGuard's modern cryptographic primitives, bypassing local untrusted networks and exiting to the public internet via a residential gateway.

### Core Components
* **VPN Protocol:** WireGuard (via PiVPN orchestration)
* **Host Platform:** Raspberry Pi OS (Debian-based)
* **Dynamic DNS:** DuckDNS API integration via automated shell scripting
* **Network Perimeter:** Edge router port-forwarding (Optimum Cloud Management)
* **Traffic Topology:** Full Tunnel (`AllowedIPs = 0.0.0.0/0`)

---

## 🚀 Deployment Steps

### Step 1: Inbound Network Perimeter Configuration (Edge Router)
Before provisioning the internal server, the edge firewall must be configured to pass external WireGuard handshakes.
1. Authenticated to the gateway administration portal (**Optimum Cloud Portal/My Optimum App**).
2. Located the **Advanced Port Forwarding** configuration matrix.
3. Created an explicit rule mapping public traffic to the internal host destination:
    * **Local IP:** Assigned Static/DHCP-Reserved IP of the Raspberry Pi (`192.168.1.189`)
    * **External/Internal Ports:** `51820`
    * **Protocol:** `UDP` (Strictly connectionless transport layer)

### Step 2: Automated Dynamic DNS (DDNS) Provisioning
Because residential public WAN IPs are dynamic, an automated daemon script was written to continuously update a custom tracking domain hosted by DuckDNS.

1. Initialized a dedicated working directory:
   ```bash
   mkdir ~/duckdns && cd ~/duckdns
   nano duckdns.sh
