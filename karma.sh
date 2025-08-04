#!/bin/bash

# Check root
if [ "$(id -u)" != "0" ]; then
    echo "Запустите скрипт с правами root: sudo ./karma.sh"
    exit 1
fi

# Определение интерфейса
detect_interface() {
    interfaces=($(iw dev | awk '/Interface/ {print $2}'))
    if [ ${#interfaces[@]} -eq 0 ]; then
        echo "Беспроводные интерфейсы не найдены!"
        exit 1
    elif [ ${#interfaces[@]} -eq 1 ]; then
        selected_interface=${interfaces[0]}
    else
        echo "Выберите интерфейс:"
        select iface in "${interfaces[@]}"; do
            selected_interface=$iface
            break
        done
    fi
    echo "Выбран интерфейс: $selected_interface"
}

# Меню атак
show_menu() {
    clear
    echo "=============================="
    echo "         МЕНЮ АТАК            "
    echo "=============================="
    echo "1. OPN"
    echo "2. WPA"
    echo "3. Brute Half"
    echo "4. QW"
    echo "5. Known Beacons"
    echo "6. PNL"
    echo "7. WPA Brute"
    echo "8. WPA Brute Width"
    echo "9. EvilTwin"
    echo "10. EAP"
    echo "0. Выход"
    echo "=============================="

    read -p "Выберите атаку [0-10]: " choice
    case $choice in
        1) launch_attack "attack-opn.sh" ;;
        2) launch_attack "attack-wpa.sh" ;;
        3) launch_attack "brute_half.sh" ;;
        4) launch_attack "qw.sh" ;;
        5) launch_attack "known_beacons.sh" ;;
        6) launch_attack "pnl.sh" ;;
        7) launch_attack "wpa-brute.sh" ;;
        8) launch_attack "wpa_brute-width.sh" ;;
        9|10) launch_attack "run.sh" ;;
        0) exit 0 ;;
        *) echo "Неверный выбор!"; sleep 1 ;;
    esac
}

# Запуск атаки
launch_attack() {
    script=$1
    if [ -f "$script" ]; then
        echo "Запуск $script на $selected_interface..."
        ./"$script" "$selected_interface"
    else
        echo "Файл $script не найден!"
        sleep 2
    fi
}

# Основной цикл
while true; do
    detect_interface
    show_menu
done
