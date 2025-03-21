#!/usr/bin/env bash

# Defining files/directories
SERVICE_NAME="file_integrity_checker"
SERVICE_FILE="$SERVICE_NAME.service"
LOGROTATE_FILE="$SERVICE_NAME"
SERVICE_PATH="/etc/systemd/system/filechecker/"
LOGROTATE_PATH="/etc/logrotate.d/"
LOGFILE_NAME="file_integrity_checker.log"
LOGFILE_PATH="/var/log/" 
SERVICE_GROUP="fileman_group"
SERVICE_USER="fileman"
INSTALL_DIR="/opt/filechecker/"
GIT_REPO_URL="https://github.com/haalanden0219/file_integrity_checker.git"

# Creating Directories and permsissions
mkdir -p "$INSTALL_DIR"
mkdir -p "$SERVICE_PATH"

# Clone git repo
cd "$INSTALL_DIR"
git clone "$GIT_REPO_URL"

# Create user files
touch "$INSTALL_DIR/baseline.hash" "$INSTALL_DIR/paths.conf" "$INSTALL_DIR/updated.hash"

#Create logging file
touch "$LOGFILE_PATH/$LOGFILE_NAME"

# Set up groups - need to set up verifications
groupadd "$SERVICE_GROUP"
useradd --system --no-create-home "$SERVICE_USER"
passwd "$SERVICE_USER"
usermod -g "$SERVICE_GROUP" "$SERVICE_USER"

# mv log and service file
mv "$INSTALL_DIR" "$SERVICE_FILE" "$SERVICE_PATH"
chown root:root "$SERVICE_PATH/$SERVICE_FILE"

mv "$INSTALL_DIR/$LOGROTATE_FILE" "$LOGROTATE_PATH"
chown root:root "$LOGROTATE_PATH/$LOGROTATE_FILE"

# Set up Ownership
chown "$SERVICE_USER":"$SERVICE_GROUP" "$INSTALL_DIR"
chown "$SERVICE_USER":"$SERVICE_GROUP" "$INSTALL_DIR/baseline.hash" "$INSTALL_DIR/paths.conf" "$INSTALL_DIR/updated.hash"

# Set up permissions
chmod 644 "$INSTALL_DIR/paths.conf"
chmod 600 "$INSTALL_DIR/updated.hash"
chmod 600 "$INSTALL_DIR/baseline.hash"

# Start the service
systemctl daemon-reload
systemctl enable filechecker
systemctl start filechecker
