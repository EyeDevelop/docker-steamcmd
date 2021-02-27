#!/bin/bash

# Create a user for game files if he did not exist.
if ! grep "steamcmd" /etc/passwd; then
    echo "[+] Creating a user."
    groupadd -g "$PGID" steamcmd
    useradd -g "$PGID" -u "$PUID" -m steamcmd
fi

# Do a directory check.
if [[ ! -d /data ]]; then
    mkdir -p /data
fi

# Make sure our user has the correct permissions.
chown -R steamcmd:steamcmd /data

# Update the game if necessary, or download it in the first place.
su steamcmd -c "/usr/games/steamcmd +login anonymous +force_install_dir /data +app_update $STEAM_APPID validate +quit"

if [[ ! -f /data/run_server.sh ]]; then
    echo "[!] No way of starting the server."
    echo "    Please make a server launcher"
    echo "    named 'run_server.sh' in the"
    echo "    data directory."
    exit 0
fi

# Make sure Steam can find the right libraries.
su steamcmd -c "ln -s /home/steamcmd/.steam/steamcmd/linux32 /home/steamcmd/.steam/sdk32"
su steamcmd -c "ln -s /home/steamcmd/.steam/steamcmd/linux64 /home/steamcmd/.steam/sdk64"

# Make sure we can execute that script.
chmod 755 /data/run_server.sh

# Launch the server.
su steamcmd -c "cd /data && /data/run_server.sh"