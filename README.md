# SteamCMD

This is a Docker container to install and run dedicated servers installed with SteamCMD.

## Usage
This container uses environment variables to download the specified game and make sure file permissions are set properly. To download the TF2 dedicated server for example, you would run the following:

```
$ docker run -dp 27005-27015:27005-27015\
                          -p 27005-27015:27005-27015/udp\
                          -v "/path/to/data:/data"
                          -e PUID=<your UID>\
                          -e PGID=<your GID>\
                          -e STEAM_APPID=232250\
                          eyedevelop/steamcmd
```

The container will then download all the files of the game you specified. After this, it will ask you to make a small shell script named 'run_server.sh' in the data directory. It runs this script on container start, after verifying and updating the game. So again, for TF2, this would be as follows:

\>> /data/run_server.sh
```bash
#!/bin/bash

./srcds_run -console -game tf +sv_pure 1 +randommap +maxplayers 24
```

## Good luck and have fun!
If you like this image, please [donate a coffee](https://paypal.me/eyegaming2) :)
