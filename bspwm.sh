#!/bin/bash

# Update package list
sudo apt-get update

# Install lightdm and bspwm
sudo apt-get install -y lightdm
sudo apt-get install -y bspwm

# Configure lightdm
sudo dpkg-reconfigure lightdm

# Update lightdm configuration to set bspwm as the default session
sudo tee /etc/lightdm/lightdm.conf > /dev/null <<EOL
[Seat:*]
greeter-session=lightdm-slick-greeter
user-session=bspwm
greeter-hide-users=false
greeter-allow-guest=true
EOL

echo "Configuration complete! Please reboot to start using bspwm with lightdm."
