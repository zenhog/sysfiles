#!/bin/bash

notify() {
    SOCK=/tmp/rofi_notification_daemon
    su - maiz -c "echo dela:ACPI | socat - UNIX-CONNECT:$SOCK"
    su - maiz -c "notify-send -a ACPI -t 5000 ACPI '${*}'"
}

timeout() {
    su - maiz -c "widget $1 timeout"
}


case "$1" in
    ac_adapter)
        case "$2" in
            AC*|AD*)
                case "$4" in
                    00000000)
                        timeout battery
                        notify Battery Discharging
                    ;;
                    00000001)
                        timeout battery
                        notify Battery Charging
                    ;;
                esac
                ;;
        esac
        ;;
    jack/headphone)
        case "$2" in
            HEADPHONE)
                case "$3" in
                    unplug)
                        su - maiz -c "widget playback mute"
                        timeout playback
                        notify Headphone Unplugged
                        ;;
                    plug)
                        su - maiz -c "widget playback unmute"
                        timeout playback
                        notify Headphone Plugged
                        ;;
                esac
        esac
        ;;
    *)
        ;;
esac
