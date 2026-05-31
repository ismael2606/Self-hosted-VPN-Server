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
* **Network Perimeter:** Edge router port-forwarding (through your local router's portal management)
* **Traffic Topology:** Full Tunnel (`AllowedIPs = 0.0.0.0/0`)

---

## 🚀 Deployment Steps

### Step 1: Inbound Network Perimeter Configuration (Edge Router)
Before provisioning the internal server, the edge firewall must be configured to pass external WireGuard handshakes.
1. Authenticated to the gateway administration portal.
2. Located the **Advanced Port Forwarding** configuration matrix.
3. Created an explicit rule mapping public traffic to the internal host destination:
    * **Local IP:** Assigned Static/DHCP-Reserved IP of the Raspberry Pi (static IP for your PI is recommended
    * **External/Internal Ports:** `51820`
    * **Protocol:** `UDP` (Strictly connectionless transport layer)

### Step 2: Automated Dynamic DNS (DDNS) Provisioning
Because residential public WAN IPs are dynamic, an automated daemon script was written to continuously update a custom tracking domain hosted by DuckDNS.

1. Initialized a dedicated working directory:
   ```bash
   mkdir ~/duckdns && cd ~/duckdns
   nano duckdns.sh
   echo url="[https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip=](https://www.duckdns.org/update?domains=YOUR_DOMAIN&token=YOUR_TOKEN&ip=)" | curl -k -o ~/duckdns/duckdns.log -K -

2. Adjust the file permissions to run the script
   ```bash
   chmod +x duckdns.sh
   
3. Registered script with Linux scheduler so it runs automatically every 5 minutes
   ```bash
   crontab -e
   */5 * * * * ~/duckdns/duckdns.sh >/dev/null 2>&1
   
4. Verified runtime success by checking the return payload:
   ```bash
   cat ~/duckdns/duckdns.log  # Output: OK

### Step 3: WireGuard Server Installation & Compilation

1. On your Raspberry Pi, run:
   ```bash
   curl -L [https://install.pivpn.io](https://install.pivpn.io) | bash
   
2. Static IP: Select <Yes> to confirm your Pi's current IP structure.

3. Local User: Highlight your primary system user, press Spacebar to select it, and hit Enter.

4. VPN Protocol: Choose WireGuard and press Enter.

5. Port Configuration: Keep the default port 51820 (matching your router rule).

6. Upstream DNS: Choose your preferred fallback public provider (like Quad9 9.9.9.9 for threat intelligence or Cloudflare 1.1.1.1 for raw speed).

6. Public IP or DNS Entry (Crucial): Arrow down to select <DNS Entry> and press Enter. On the text input screen, type your exact DuckDNS domain: yourname.duckdns.org.

7. Unattended Upgrades: Select <Yes> to enable automatic daily security patches.

8. Reboot: Let the installer finish and select <Yes> to reboot the Raspberry Pi.

### Step 4: Create Profiles and Connect Remote Devices
Once the Pi boots back up, your network loop is completely configured.

1. Create a profile:

```bash
   pivpn add
```
2. Press Enter to skip the optional virtual IP range step.

3. Type a clear name for your device (e.g., iPhone) and hit Enter.

## Connect a Phone:

1. Run pivpn -qr, select your profile number, and scan the terminal QR code with the official mobile WireGuard app.

2. Test: Turn off your phone's Wi-Fi, toggle the WireGuard tunnel ON over cellular data, and verify you have full internet access. You can run `pivpn -c` on the Pi to see your active data handshake packets transferring back and forth.

## For Your Laptop or Desktop (macOS / Windows / Linux)

1. **Extract the Configuration File:** You must pull the unique `.conf` file generated for your laptop from the Pi WireGuard directory down onto your local computer. Use  standard secure copy (SCP) routine from your laptop's terminal:
   ```bash
   scp pi@local_ip_here:~/configs/YourLaptopProfile.conf ./
   
2. Import into the Client: * Download and install the official desktop client from wireguard.com/install.

3. Open the WireGuard application interface, click Import tunnel(s) from file (or click the + dropdown menu), and select the downloaded .conf file.

4. Test: Tether your laptop to an untrusted external network connection (e.g., your phone's cellular hotspot or a public Wi-Fi network). Do not test while the laptop is sitting directly on your home Wi-Fi, or it will short-circuit the external gateway routing logic.

   * Toggle the WireGuard tunnel switch to ON within the application interface.

   * Open your laptop's terminal or web browser to ensure you have internet access.


