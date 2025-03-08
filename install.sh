#!/usr/bin/env bash

# Defining files/directories
SERVICE_NAME="file_integrity_checker"
SERVICE_PATH="/etc/systemd/system/filechecker/"
SERVICE_GROUP="fileman_group"
SERVICE_USER="fileman"
INSTALL_DIR="/opt/filechecker/"


# Creating Directories and permsissions
mkdir -p "$INSTALL_DIR"
mkdir -p "$SERVICE_PATH"
#add ownership and groups
#add ownership and groups
#add permissions - Install Dir
#add permissions - service path

# Create logging files
touch "$INSTALL_DIR/baseline.hash"
touch "$INSTALL_DIR/paths.conf"
touch "$INSTALL_DIR/updated.hash"


# Copy files
#cp file_integrity_checker.service /etc/systemd/system/
# Set up permissions

# Set up groups - need to set up verifications
groupadd fileman_group
useradd -m -d /opt/filechecker fileman
passwd fileman
usermod -g fileman_group fileman


# Start the service

