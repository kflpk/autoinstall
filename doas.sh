#!/bin/bash

if [ -e /bin/doas ]; then
    return 0
else 
    # INSTALLING BUILD TOOLS DEPENDING ON THE OS
    if [ -e /bin/apt ]; then
        $SUDO apt install build-essential make bison flex libpam0g-dev 
    else if [ -e /bin/dnf ]; then
        $SUDO dnf install gcc gcc-c++ make flex bison pam-devel byacc
    else
        echo 'distro not found'
        return 1
    fi
    fi 

    # BUILD DOAS FROM SOURCE
    git clone "https://github.com/slicer69/doas" /tmp/doas
    cd /tmp/doas
    make
    $SUDO make install
    $SUDO bash -c "echo permit persist $USER as root >> /usr/local/etc/doas.conf"
fi