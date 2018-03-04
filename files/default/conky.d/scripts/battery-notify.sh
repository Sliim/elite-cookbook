#!/usr/bin/env bash
acpi -V | grep Battery 2>&1 >/dev/null || exit 1
ls /sys/class/power_supply/BAT* 2>&1 >/dev/null  || exit 2
battery_info=$(acpi -V | grep Battery | awk 'NR==1')

battery_status=$(echo $battery_info | sed 's/^Battery 0: \([a-zA-Z]*\)\(.*\)/\1/')
battery_percentage=$(echo $battery_info | sed 's/^Battery 0: [a-zA-Z]*, \([0-9]*\)%.*/\1/')
if [ $battery_status == "Discharging" -a $battery_percentage -lt 15 ]; then
    notify-send "WTF Battery Low" \
        "$battery_percentage% remainting." \
        -i battery-caution -u critical
fi
