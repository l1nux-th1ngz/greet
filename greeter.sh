#!/bin/bash
# Update package list
sudo apt-get update

# Install lightdm
if ! sudo apt-get install -y lightdm; then
    echo "Failed to install lightdm. Please check your package manager or sources."
    exit 1
fi

# Install lightdm gtk greeter
if ! sudo apt-get install -y lightdm-gtk-greeter; then
    echo "Failed to install lightdm gtk greeter. Please check your package manager or sources."
    exit 1
fi

# Install slick-greeter
if ! sudo apt-get install -y slick-greeter; then
    echo "Failed to install slick-greeter. Please check your package manager or sources."
    exit 1
fi

# Download lightdm settings package
wget http://packages.linuxmint.com/pool/main/l/lightdm-settings/lightdm-settings_2.0.5_all.deb

# Install lightdm settings package
sudo dpkg -i lightdm-settings_2.0.5_all.deb

# Configure lightdm
if ! sudo dpkg-reconfigure lightdm; then
    echo "Failed to reconfigure lightdm. Please check the output for errors."
    exit 1
fi

# Update lightdm configuration to set bspwm as the default session
sudo tee /etc/lightdm/lightdm.conf > /dev/null <<EOL
[Seat:*]
greeter-session=slick-greeter
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

echo "Configuration complete! Please reboot to start using bspwm with LightDM."
