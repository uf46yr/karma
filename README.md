# KARMA Wireless Attack Tool

![Banner](https://via.placeholder.com/800x200?text=KARMA+Wireless+Attack+Tool+v2.0)  
Advanced Wi-Fi penetration testing toolkit with automated attack selection and cross-platform support.

## Features
- 🛡️ **Root permission validation** with OS-specific instructions
- 📶 **Automatic wireless interface detection**
- 🎨 **Color-coded interactive menu system**
- ⚔️ **10+ specialized attack vectors**:
  - OPN/WPA network attacks
  - Bruteforce (standard/wide/half variants)
  - Beacon flooding
  - EvilTwin setups
  - EAP attacks
- 📱 **Full Termux compatibility** (Android)
- 🐧 **Linux support** (Kali, Parrot OS, etc.)
- 🔄 **Automatic permission management**

## Requirements
- `iw` or `iwconfig` utilities
- Wireless interface in monitor mode
- Root access (via `sudo` or Termux `tsu`)

## Installation
```bash
git clone https://github.com/uf46yr/karma/

cd karma

chmod +x karma.sh
```
## Usage
### Linux
```bash
sudo ./karma.sh
```
### Termux (Android)
```bash
tsu -e ./karma.sh
```

## Attack Menu Overview
| #  | Attack Method         | Script Name           | Description                     |
|----|-----------------------|-----------------------|---------------------------------|
| 1  | OPN Attack            | `attack-opn.sh`       | Open network exploitation      |
| 2  | WPA Attack            | `attack-wpa.sh`       | WPA handshake capture          |
| 3  | Half Bruteforce       | `brute_half.sh`       | Optimized dictionary attacks   |
| 4  | QW Attack             | `qw.sh`               | Quick connect vulnerabilities  |
| 5  | Known Beacons         | `known_beacons.sh`    | Beacon flood with known SSIDs  |
| 6  | PNL Attack            | `pnl.sh`              | Preferred Network List exploit |
| 7  | WPA Bruteforce        | `wpa-brute.sh`        | Standard WPA cracking          |
| 8  | Wide WPA Bruteforce   | `wpa_brute-width.sh`  | Extended character set attack  |
| 9  | EvilTwin              | `run.sh`              | Rogue AP setup                 |
| 10 | EAP Attack            | `run.sh`              | Enterprise network attacks     |

## Visual Interface Preview
```ascii
╔════════════════════════════════════════════════╗
║ ██╗  ██╗ █████╗ ██████╗ ███╗   ███╗ █████╗    ║
║ ██║ ██╔╝██╔══██╗██╔══██╗████╗ ████║██╔══██╗   ║
║ █████╔╝ ███████║██████╔╝██╔████╔██║███████║   ║
║ ██╔═██╗ ██╔══██║██╔══██╗██║╚██╔╝██║██╔══██║   ║
║ ██║  ██╗██║  ██║██║  ██║██║ ╚═╝ ██║██║  ██║   ║
║ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ║
╠════════════════════════════════════════════════╣
║              ATTACK MENU                       ║
╠════════════════════════════════════════════════╣
║ 1. OPN Attack                                 ║
║ 2. WPA Attack                                 ║
║ 3. Half Bruteforce                            ║
║ ...                                           ║
╚════════════════════════════════════════════════╝
```

## Notes
- 🔐 **Legal Compliance**: Use only on networks you own or have explicit permission to test
- ⚠️ **Interface Requirements**: Wireless must support monitor mode
- 📂 **File Structure**: Keep all attack scripts in same directory as `karma.sh`
- 🔄 **Termux Limitations**: Requires root via `tsu` and custom kernel features

## License
GNU General Public License v3.0 - See [LICENSE](LICENSE) file for details
```

### Key Features Highlighted:
1. **Cross-Platform Design**  
   Special handlers for both Linux and Termux environments

2. **Intelligent Interface Detection**  
   Triple-layer scanning using:
   - `iw` utility
   - `iwconfig` fallback
   - SysFS directory parsing

3. **Visual Security**  
   Color-coded warnings and status messages:
   - 🔴 `RED`: Critical errors/permission issues
   - 🟢 `GREEN`: Success confirmations
   - 🟡 `YELLOW`: Warnings/selections
   - 🔵 `BLUE`: User prompts

4. **Attack Script Management**  
   Automatic permission correction and path validation

5. **User Experience**  
   - Interactive menu with post-execution pause
   - Clear exit instructions
   - Error prevention for invalid selections

> **Warning**: This tool is for educational purposes only. Unauthorized network access is illegal in most jurisdictions. Always obtain proper authorization before conducting security assessments.
