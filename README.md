# XIVLauncher-SCT
**XIVLauncher.Core built into a Steam Compatibility Tool**

## Installation
Download the latest release, and unpack to `~/.local/share/Steam/compatibilitytools.d` or `~/.var/app/com.valvesoftware.Steam/.local/share/compatibilitytools.d` (flatpak Steam).

For new FFXIV installs: after installing FFXIV, you need to run it once with default options. You do not need to log in with the SquareEnix launcher, just run it once. This will ensure at least one proton version is installed, and also install some files that Steam needs in order think FFXIV is actually installed properly.

Open Steam, and right-click on Final Fantasy XIV. Properties > Compatibility > Force the use of a specific Steam Play compatibility tool and select XIVLauncher.Core from the dropdown menu.

## Configuration 
There are a few differences between this build and the standard XIVLauncher.Core flatpak.

- The GamePath will *by default* be set by Steam. So wherever steam wants to install (or has installed) FFXIV will automatically be used. You can override this to point to an existing install. The GameConfigPath, will have a default path of `$XDG_DATA_HOME/xivlauncher-sct/ffxivConfig` which can also be overridden. ($XDG_DATA_HOME is usually `~/.local/share`, or `~/.var/app/com.valvesoftware.Steam/.local/share` for flatpak Steam)

    Examples to move/link the game from an existing XIVLauncher.Core install:
    >
    >`mv ~/.xlcore/ffxiv "~/.local/share/Steam/steamapps/common/FINAL FANTASY XIV Online"`
    >     
    >`ln -s ~/.xlcore/ffxiv "/run/media/mmcblk0p1/SteamLibrary/steamapps/common/FINAL FANTASY XIV Online"`
    >      
    >Note that you have to put "quotes" around the path if it contains spaces, as above.

- With version 0.5, XIVLauncher-SCT is run inside of a steam sniper container. As such, it *does not* have access to your whole filesystem. If your files are stored in another location, you'll need to set `STEAM_COMPAT_MOUNTS` in your launch options.

     Example for launch options:

    >`STEAM_COMPAT_MOUNTS=/run/media/mmcblk0p1/ffxiv:/run/media/mmcblk0p1/ffxivConfig %command%`
    >
    >`MANGOHUD=1 STEAM_COMPAT_MOUNTS="$XDG_RUNTIME_DIR/discord-ipc-0:/games/other/FFXIV/ffxivConfig" gamescope --force-grab-cursor -f -H 2160 -h 1440 -F fsr --adaptive-sync --immediate-flips -r 120 -- %command%`
    >
    >The second one is an example that includes enabling mangohud and using gamescope, and also exporting a point for the wine discord ipc bridge.

    If you are using flatpak steam, you will also have to share these paths with steam using flatseal.

- Proton is the only option. The Wine Tab from XIVLauncher.Core is now the Proton tab. This does mean that running two accounts simultaneously probably won't work; if you want to do that use the default XIVLauncher.
    
    DXVK ASYNC does nothing for Valve's proton libs, and only works for GE-Proton 7-44 and earlier.

    If you are using flatpak Steam, you need to install MangoHud as a flatpak to use it.

- I strongly recommend setting a delay for Dalamud. It tends to crash otherwise. 5000 ms seems to work.

- There is now a Troubleshooting tab in the Settings menu. This has some buttons to clear wine and proton prefixes, xlcore compatibilitytools folder, dalamud plugins, and log files, as well as generate a tspack.

- I have done all the compiling in an Ubuntu 22.04 container. Hopefully that will allow this to run on just about anything modern. aria2c is included in the `bin/` directory in case it's not installed on the user's system. It's taken from Ubuntu 22.04, and a copy of the GPL 2.0 license is included (as aria2 uses that license). Source code can be found at https://github.com/aria2/aria2

- **IMPORTANT** This tool now wraps itself in the sniper runtime. This can cause a few seconds of delay before the launcher actually appears. Additionally, it will occasionally just fail to launch (The button will go from Play to Cancel, briefly to Stop, and then back to Play). Just relaunch it. 

## Troubleshooting

This is early-release software and may not be particularly stable. I've added a couple of logfiles to help with debugging. There's also a troubleshooting tab in the Settings menu. This has buttons to delete the wine and proton prefixes, as well as dalamud files and log files. You can also try launching without dalamud, or setting a 5000 ms or longer delay.

- **This does not use the same config folder as XIVLauncher.Core.** Instead of `~/.xlcore`, it uses `$XDG_DATA_HOME/xivlauncher-sct`. For most users, this will be `~/.local/share/xivlauncher-sct` or `~/.var/app/com.valvesoftware.Steam/.local/share/xivlauncher-sct` (flatpak Steam).

- You will find a console output logfile at `$XDG_DATA_HOME/Steam/logs/console_log.txt` (or `~/.var/app/com.valvesoftware.Steam/.local/share/Steam/logs/console_log.txt` for flatpak). This file will contain output from XIVLauncher's console log. This might let you see errors that don't get caught by XIVLauncher's internal logging.

- There's an environment variable logfile at `$XDG_DATA_HOME/xivlauncher-sct/logs/steamenv.log`. This file contains all the environment variables that are active when XIVLauncher.Core starts up.

- There's also XIVLauncher's own logfiles, particularly `launcher.log`, also in `$XDG_DATA_HOME/xivlauncher-sct`.

- You might not be able to get help from the official XIVLauncher discord. I'm usually there, but this is significantly different from stock XIVLauncher.Core, so other people may not want to or be able to help. If you have problems, make an issue on this github repo, and I'll try to check it out when I get the chance.

## Building
Clone the repo with `git clone --recurse-submodules https://github.com/rankynbass/XIVLauncher-SCT.git`. Open up the paths.sh script and adjust if needed. Build the tool with ./build.sh. This will put a tar.gz file in the out/ directory. Unzip that to `~/.local/share/Steam/compatibilitytools.d/` or `~/.var/app/com.valvesoftware.Steam/.local/share/Steam/compatibilitytools.d` (flatpak Steam). Then restart Steam.

If you are making changes and testing, you may be tempted to link the out/XIVLauncher folder into the compatibilitytools.d folder. Don't; Steam doesn't follow links in that directory to see if there's anything valid. You *can* link the xlcore-bin folder inside the XIVLauncher folder, however.