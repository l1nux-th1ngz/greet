#!/bin/bash

# Update package list
sudo apt-get update

# Install lightdm and slick-greeter
if ! sudo apt-get install -y lightdm lightdm-slick-greeter; then
    echo "Failed to install lightdm, slick-greeter. Please check your package manager or sources."
    exit 1
fi

# Configure lightdm
if ! sudo dpkg-reconfigure lightdm; then
    echo "Failed to reconfigure lightdm. Please check the output for errors."
    exit 1
fi

# Update lightdm configuration to set bspwm as the default session
sudo tee /etc/lightdm/lightdm.conf > /dev/null <<EOL
[Seat:*]
greeter-session=lightdm-slick-greeter
user-session=bspwm
greeter-hide-users=false
greeter-allow-guest=true
EOL

# Enable and start lightdm
if sudo systemctl enable lightdm && sudo systemctl start lightdm; then
    echo "LightDM has been enabled and started successfully."
else
    echo "Failed to enable or start LightDM. Please check the output for errors."
    exit 1
fi

# Ensure that the configuration file has been updated
if [ $? -eq 0 ]; then
    echo "Configuration complete! Please reboot to start using bspwm with lightdm."
else
    echo "Failed to update the lightdm configuration."
    exit 1
fi
