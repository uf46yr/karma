#!/bin/bash

# Colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Root privileges check with colored styling
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo -e "${RED}╔════════════════════════════════════════════════╗"
        echo -e "║${YELLOW} WARNING: Script requires root privileges! ${RED}          ║"
        echo -e "╠════════════════════════════════════════════════╣"

        if [ -n "$TERMUX_VERSION" ]; then
            echo -e "║ ${CYAN}For Termux: run with: ${GREEN}tsu -e${NC}${RED}                ║"
            echo -e "║ ${CYAN}Example: ${GREEN}tsu -e ./${0##*/}${NC}${RED}                  ║"
        else
            echo -e "║ ${CYAN}For Linux: run with: ${GREEN}sudo${NC}${RED}                  ║"
            echo -e "║ ${CYAN}Example: ${GREEN}sudo ./${0##*/}${NC}${RED}                    ║"
        fi

        echo -e "╚════════════════════════════════════════════════╝${NC}"
        exit 1
    fi
}

# Function to detect wireless interfaces
detect_interface() {
    echo -e "${BLUE}▶${NC} ${CYAN}Scanning for wireless interfaces...${NC}"

    # Try different interface detection methods
    if command -v iw >/dev/null 2>&1; then
        interfaces=($(iw dev 2>/dev/null | awk '/Interface/ {print $2}'))
    elif command -v iwconfig >/dev/null 2>&1; then
        interfaces=($(iwconfig 2>/dev/null | grep -E '^[[:alnum:]]' | awk '{print $1}'))
    fi

    # Fallback to sysfs method
    if [ ${#interfaces[@]} -eq 0 ]; then
        interfaces=($(ls /sys/class/net/ | grep -E 'wlan[0-9]+|wlp[0-9]+s[0-9]+'))
    fi

    # Interface selection logic
    if [ ${#interfaces[@]} -eq 0 ]; then
        echo -e "${RED}✖${NC} No wireless interfaces found!${NC}"
        exit 1
    elif [ ${#interfaces[@]} -eq 1 ]; then
        selected_interface=${interfaces[0]}
        echo -e "${GREEN}✔${NC} Using interface: ${YELLOW}$selected_interface${NC}"
    else
        echo -e "${GREEN}✔${NC} Available interfaces:"
        PS3=$'\n'"${BLUE}?${NC} Select interface (1-${#interfaces[@]}): "
        select selected_interface in "${interfaces[@]}"; do
            if [ -n "$selected_interface" ]; then
                echo -e "${GREEN}✔${NC} Selected interface: ${YELLOW}$selected_interface${NC}"
                break
            else
                echo -e "${RED}✖${NC} Invalid selection, please try again${NC}"
            fi
        done
    fi
}

# Function to display colored attack menu
show_menu() {
    clear
    echo -e "${PURPLE}╔════════════════════════════════════════════════╗"
    echo -e "║${YELLOW} ██╗  ██╗ █████╗ ██████╗ ███╗   ███╗ █████╗ ${PURPLE}║"
    echo -e "║${YELLOW} ██║ ██╔╝██╔══██╗██╔══██╗████╗ ████║██╔══██╗${PURPLE}║"
    echo -e "║${YELLOW} █████╔╝ ███████║██████╔╝██╔████╔██║███████║${PURPLE}║"
    echo -e "║${YELLOW} ██╔═██╗ ██╔══██║██╔══██╗██║╚██╔╝██║██╔══██║${PURPLE}║"
    echo -e "║${YELLOW} ██║  ██╗██║  ██║██║  ██║██║ ╚═╝ ██║██║  ██║${PURPLE}║"
    echo -e "║${YELLOW} ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝${PURPLE}║"
    echo -e "╠════════════════════════════════════════════════╣"
    echo -e "║             ${CYAN}ATTACK MENU ${PURPLE}                     ║"
    echo -e "╠════════════════════════════════════════════════╣"
    echo -e "║ ${GREEN}1.${NC} OPN Attack                          ${PURPLE}║"
    echo -e "║ ${GREEN}2.${NC} WPA Attack                          ${PURPLE}║"
    echo -e "║ ${GREEN}3.${NC} Half Bruteforce                     ${PURPLE}║"
    echo -e "║ ${GREEN}4.${NC} QW Attack                           ${PURPLE}║"
    echo -e "║ ${GREEN}5.${NC} Known Beacons                       ${PURPLE}║"
    echo -e "║ ${GREEN}6.${NC} PNL Attack                          ${PURPLE}║"
    echo -e "║ ${GREEN}7.${NC} WPA Bruteforce                      ${PURPLE}║"
    echo -e "║ ${GREEN}8.${NC} Wide WPA Bruteforce                 ${PURPLE}║"
    echo -e "║ ${GREEN}9.${NC} EvilTwin                            ${PURPLE}║"
    echo -e "║ ${GREEN}10.${NC} EAP Attack                         ${PURPLE}║"
    echo -e "║ ${RED}0.${NC} Exit                                ${PURPLE}║"
    echo -e "╚════════════════════════════════════════════════╝${NC}"

    while true; do
        read -p "$(echo -e "${BLUE}?${NC} Select attack [0-10]: ")" choice
        case $choice in
            1) launch_attack "attack-opn.sh"; break ;;
            2) launch_attack "attack-wpa.sh"; break ;;
            3) launch_attack "brute_half.sh"; break ;;
            4) launch_attack "qw.sh"; break ;;
            5) launch_attack "known_beacons.sh"; break ;;
            6) launch_attack "pnl.sh"; break ;;
            7) launch_attack "wpa-brute.sh"; break ;;
            8) launch_attack "wpa_brute-width.sh"; break ;;
            9|10) launch_attack "run.sh"; break ;;
            0) echo -e "${YELLOW}▶${NC} Exiting..."; exit 0 ;;
            *) echo -e "${RED}✖${NC} Invalid selection, please try again" ;;
        esac
    done
}

# Function to launch attacks
launch_attack() {
    script=$1
    if [ -f "$script" ]; then
        echo -e "${YELLOW}▶${NC} Launching ${GREEN}$script${NC} on ${YELLOW}$selected_interface${NC}..."

        # Check execution permissions
        if [ ! -x "$script" ]; then
            echo -e "${YELLOW}▶${NC} Setting execute permissions for ${GREEN}$script${NC}..."
            chmod +x "$script"
        fi

        ./"$script" "$selected_interface"

        # Pause after execution
        echo -e "${BLUE}▶${NC} Press Enter to continue..."
        read
    else
        echo -e "${RED}✖${NC} Error: file ${YELLOW}$script${RED} not found!${NC}"
        echo -e "${YELLOW}▶${NC} Ensure all attack scripts are in the same directory"
        sleep 2
    fi
}

# Main function
main() {
    check_root
    echo -e "${PURPLE}╔════════════════════════════════════════════════╗"
    echo -e "║ ${CYAN}KARMA Wireless Attack Tool ${YELLOW}v2.0${PURPLE}               ║"
    echo -e "╠════════════════════════════════════════════════╣"
    echo -e "║ ${GREEN}Supports Linux and Termux${PURPLE}                     ║"
    echo -e "╚════════════════════════════════════════════════╝${NC}"

    detect_interface
    while true; do
        show_menu
    done
}

# Launch main function
main
