## 🎯 Project TL;DR
This project establishes a self-hosted, full-tunnel VPN gateway deployed on a Raspberry Pi backbone utilizing the modern **WireGuard** protocol layer and **DuckDNS** as the automated Dynamic DNS (DDNS) provider. Deploying this architecture allows remote client devices (such as laptops and smartphones) to securely intercept, encrypt, and route traffic straight back to home network resources from anywhere in the world over untrusted public WAN perimeters.

---

## 🛠️ Tech Stack & Specifications

| Component | Technology / Protocol | Operational Detail |
| :--- | :--- | :--- |
| **Operating System** | Raspberry Pi OS | Debian 12 Bookworm (64-bit ARM Architecture) |
| **VPN Core Layer** | WireGuard | Modern cryptographic primitives (ChaCha20-Poly1305) |
| **Network Protocol** | `UDP` | Stateful transport layer listening on Port **`51820`** |
| **DNS Configuration** | DuckDNS + Cloudflare | Automated DDNS tracking domain with secure upstream resolvers |
| **Automation Engine** | Linux `cron` Daemon | Scheduled Bash shell script execution loops |

---

## 🚀 Step-by-Step Deployment Phases

### Phase 1: Inbound Network Perimeter (Edge Router)
Established a permanent internal local DHCP IP reservation for the Raspberry Pi host hardware and explicitly provisioned a network-layer **Port Forwarding rule** for incoming traffic mapped to **UDP port 51820** on the ISP residential gateway.

### Phase 2: Automation & Persistence Pipelines
Configured an automated background script loop backed by the Linux system scheduler (`cron`) to systematically monitor, capture, and update rotating residential public WAN IP shifts against a custom tracking domain hosted by DuckDNS.

### Phase 3: WireGuard Protocol Orchestration
Executed the structural deployment compilation wrapper to initialize the virtual network bridge interface (`wg0`). Simultaneously enforced security hardening by initializing the `Unattended-Upgrades` engine to fetch and apply vital operating system security patches automatically on a daily interval.

### Phase 4: Peer Cryptographic Enrollment
Generated custom asymmetric keypairs for isolated client endpoints. Successfully extracted laptop configuration scripts over encrypted channels using Secure Copy Protocol (`scp`) and generated interactive console-based ASCII QR codes for streamlined mobile provisioning.

---

## 📋 Infrastructure Management Cheat Sheet

The following native CLI shortcuts are used to manage client peers, audit data throughput, and analyze infrastructure health directly from the host system terminal:

* `pivpn add` — Generates a clean asymmetric cryptographic profile template for a new device.
* `pivpn -c` — Pulls down real-time metrics tracking active peer connections, handshake timelines, and bandwidth data transfer.
* `pivpn -d` — Compiles and executes a system-wide diagnostic framework to analyze config health and flag errors.
* `pivpn -qr` — Projects a secure console-based ASCII QR code matrix matching an existing peer profile to instantly provision iOS/Android endpoints through the native WireGuard app interface.
