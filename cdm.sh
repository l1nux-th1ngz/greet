#!/bin/bash
# Clone the CDM repository
if ! git clone https://github.com/evertiro/cdm.git; then
    echo "Failed to clone the CDM repository. Please check your internet connection or the repository URL."
    exit 1
fi

# Navigate to the cdm directory and run install script
cd cdm || exit
if ! bash install.sh; then
    echo "Failed to run the install script. Please check the output for errors."
    exit 1
fi

# Append CDM to the profile
if ! cat /usr/share/doc/cdm/profile.sh >> "$HOME/.profile"; then
    echo "Failed to append CDM to the profile. Please check the output for errors."
    exit 1
fi

echo "CDM installation and configuration complete! Please restart your session to apply the changes."
