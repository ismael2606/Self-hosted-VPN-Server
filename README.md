#### TL;DR This is a project targeted to set up a VPN server with Raspberry Pi using Wireguard and DuckDNS as the DDNS provider. Having this setup in place allows to to access network resources outside your local network.


## Tech Stack 💻

* **Operating System:** Raspberry Pi OS (Debian 12 Bookworm, 64-bit Architecture).
* **VPN Layer:** WireGuard.
* **Network Protocol:** `UDP` using port 51820
* **DNS Configuration:** DuckDNS as DDNS service and Clouflare as DNS resolver (but you can choose different providers during the wizar installation).
* **Automation:** Linux cron engine + Bash Shell scripts


Step-by-Step Production Deployment
The modular execution logs we updated previously, organized in logical, linear order:

Phase 1: Perimeter Firewalls: Setting the Static DHCP reservation and opening UDP port 51820 on your ISP gateway.

Phase 2: Automation Pipelines: Provisioning the cron daemon and the shell script to dynamically map your rotating public IP to your DuckDNS pointer.

Phase 3: WireGuard Orchestration: Running the deployment wrapper and configuring security parameters (like automated daily system updates).

Phase 4: Client Enrollment: Securely extracting laptop profiles via Secure Copy Protocol (scp) and generating mobile QR code sheets.


## Management commands cheat sheet 📋

A quick-reference table or list for managing the infrastructure after deployment

* `pivpn add` — Initiate a new profile template.

* `pivpn -c` — Pull up live peer bandwidth tracking data.

* `pivpn -d` — debug mode.

* `pivpn -qr` - Create QR code from profile to setup VPN tunnel on Android/iOS through the Wireguard app.

