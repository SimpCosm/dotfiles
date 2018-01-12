#!/bin/env bash
#
# Copyright (C) 2018 All Rights Reserved.
#
# Author:          Houmin Wei  <houmin.wei@outlook.com>
# Created:         Thu 11 Jan 2018 02:45:43 PM CST
# Last Modified:   Fri 12 Jan 2018 06:30:32 PM CST

if [[ -f `pwd`/sharedfuncs ]]; then
    source `pwd`/sharedfuncs
else
    echo "missing file: sharedfuncs"
    exit 1
fi

welcome() { #{{{
    clear
    echo -e "${Bold}Welcome to the Arch Ultimate Install script by houmin${White}"
    print_line
    echo "Requirements:"
    echo "-> Arch linux installation"
    echo "-> Run script as root user"
    echo "-> Working internet connection"
    print_line
    echo "Script can be cancelled at any time with Ctrl+C"
    print_line
    #TODO
} #}}}

language_selector() {

}

select_user() {

}

configure_sudo() {

}

#AUR HELPER {{{
choose_aurhelper() {

}
#}}}

#AUTOMODE {{{
automatic_mode() {

}
#}}}

#CUSTOM REPOSITORIES {{{
add_custom_repos() {

}
#}}}

#BASIC SETUP {{{
install_basic_setup() {

}
#}}}

#SSH {{{
install_ssh() {

}
#}}}

#NFS {{{
install_nfs() {

}
#}}}

#ZSH {{{
install_zsh() {

}
#}}}

#SAMBA {{{
install_samba() {

}
#}}}

#READAHEAD {{{
enable_readahead() {

}
#}}}

#ZRAM {{{
install_zram() {

}
#}}}

#TLP {{{
install_tlp() {

}
#}}}

#XORG {{{
install_xorg() {

}
#}}}

#FONT CONFIGURATION {{{
font_config() {

}
#}}}

#VIDEO CARDS {{{
create_ramdisk_enviroment() {

}

install_video_cards() {

}
#}}}

#CUPS {{{
install_cups() {

}
#}}}

#ADDITIONAL FIRMWARE {{{
install_additional_firmwares() {

}
#}}}

#DESKTOP ENVIROMENT {{{
install_desktop_enviroment() {

}
#}}}

#CONNMAN/NETWORKMANAGER/WICD {{{
install_nm_wicd() {

}
#}}}

#USB 3G MODEM {{{
install_usb_modem() {

}
#}}}

#ACCESSORIES {{{
install_accessories_apps() {

}
#}}}

#DEVELOPMENT {{{
install_development_apps() {

}
#}}}

#OFFICE {{{
install_office_apps() {

}
#}}}

#SYSTEM TOOLS {{{
install_system_apps() {

}
#}}}

#GRAPHICS {{{
install_graphics_apps() {

}
#}}}

#INTERNET {{{
install_internet_apps() {

}
#}}}

#AUDIO {{{
install_audio_apps() {

}
#}}}

#VIDEO {{{
install_video_apps() {

}

#GAMES {{{
install_games() {

}
#}}}

#WEBSERVER {{{
install_web_server() {

}
#}}}

#FONTS {{{
install_fonts() {

}
#}}}

#CLEAN ORPHAN PACKAGES {{{
clean_orphan_packages() {

}
#}}}

#RECONFIGURE SYSTEM {{{
reconfigure_system() {

}
#}}}

#EXTRA {{{
install_extra() {

}
#}}}

#FINISH {{{
finish() {
    print_title "WARNING: PACKAGES INSTALLED FROM AUR"
    print_danger "List of packages not officially supported that may kill your cat: "
    pause_function
    AUR_PKG_LIST="${ARCH_DIR}/aur_pkg_list.log"
    pacman -Qm | awk '{print $1}' > $AUR_PKG_LIST
    less $AUR_PKG_LIST
    print_title "INSTALL COMPLETED"
    echo -e "Thanks for using the Archlinux Ultimate Install script by houmin\n"
    #REBOOT
    read -p "Reboot your system [y/N]: " OPTION
    [[ $OPTION == y ]] && reboot
    exit 0
}
#}}}

welcome
check_root
check_archlinux
check_hostname
check_connection
check_pacman_blocked
check_multilib
pacman_key
system_update
language_selector
configure_sudo
select_user
choose_aurhelper
automatic_mode

if is_package_installed "kdebase-workspace"; then KDE=1; fi

while true
do
    print_title "Archlinux Ultimate Install"
    print_warning "Username: ${username}"
    echo " 1) $(mainmenu_item "${checklist[1]}" "Basic Setup")"
    echo " 2) $(mainmenu_item "${checklist[2]}" "Desktop Environment | Window Manager")"
    echo " 3) $(mainmenu_item "${checklist[3]}" "Accessories Apps")"
    echo " 4) $(mainmenu_item "${checklist[4]}" "Development Apps")"
    echo " 5) $(mainmenu_item "${checklist[5]}" "Office Apps")"
    echo " 6) $(mainmenu_item "${checklist[6]}" "System Apps")"
    echo " 7) $(mainmenu_item "${checklist[7]}" "Graphics Apps")"
    echo " 8) $(mainmenu_item "${checklist[8]}" "Internet Apps")"
    echo " 9) $(mainmenu_item "${checklist[9]}" "Audio Apps")"
    echo "10) $(mainmenu_item "${checklist[10]}" "Video Apps")"
    echo "11) $(mainmenu_item "${checklist[11]}" "Games")"
    echo "12) $(mainmenu_item "${checklist[12]}" "Web Server")"
    echo "13) $(mainmenu_item "${checklist[13]}" "Fonts")"
    echo "14) $(mainmenu_item "${checklist[14]}" "Extra")"
    echo "15) $(mainmenu_item "${checklist[15]}" "Clean Orphan Packages")"
    echo "16) $(mainmenu_item "${checklist[16]}" "Reconfigure System")"
    echo ""
    echo " q) Quit"
    echo ""
    MAINMENU+=" q"
    read_input_options "$MAINMENU"
    for OPT in ${OPTIONS[@]}; do
        case "$OPT" in
            1)
                add_custom_repos
                install_basic_setup
                install_zsh
                install_ssh
                install_nfs
                install_samba
                install_tlp
                enable_readahead
                install_zram
                install_video_cards
                install_xorg
                font_config
                install_cups
                install_additional_firmwares
                checklist[1]=1
                ;;
            2)
                if [[ checklist[1] -eq 0]]; then
                    print_danger "\WARNING: YOU MUST RUN THE BASIC SETUP FIRST"
                    read_input_text "Are you sure you want to continue?"
                    [[ $OPTION != y ]] && continue
                fi
                install_desktop_enviroment
                install_nm_wicd
                install_usb_modem
                checklist[2]=1
                ;;
            3)
                install_accessories_apps
                checklist[3]=1
                ;;
            4)
                install_development_apps
                checklist[4]=1
                ;;
            5)
                install_office_apps
                checklist[5]=1
                ;;
            6)
                install_system_apps
                checklist[6]=1
                ;;
            7)
                install_graphics_apps
                checklist[7]=1
                ;;
            8)
                install_audio_apps
                checklist[8]=1
                ;;
            9)
                install_audio_apps
                checklist[9]=1
                ;;
            10)
                install_video_apps
                checklist[10]=1
                ;;
            11)
                install_games
                checklist[11]=1
                ;;
            12)
                install_web_server
                checklist[12]=1
                ;;
            13)
                install_fonts
                checklist[13]=1
                ;;
            14)
                install_extra
                checklist[14]=1
                ;;
            15)
                clean_orphan_packages
                checklist[15]=1
                ;;
            16)
                print_danger "\nWARNING: THIS OPTION WILL RECONFIGURE THING LIKE HOSTNAME, TIMEZONE, CLOCK..."
                read_input_text "Are you sure you want to continue?"
                [[ $OPTION != y ]] && continue
                reconfigure_system
                checklist[16]=1
                ;;
            "q")
                finish
                ;;
            *)
                invalid_option
                ;;
        esac
    done
done
#}}}
