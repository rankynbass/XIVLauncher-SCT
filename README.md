# XIVLauncher-SCT
## XIVLauncher.Core built into a Steam Compatibility Tool

Clone the repo, then build the tool with ./build.sh. This will put a tar.gz file in the `out/` directory. Unzip that to `~/.local/share/Steam/compatibilitytools.d/`. Then restart Steam.

Open Steam, and right-click on Final Fantasy XIV. Properties > Compatibility > Force the use of a specific Steam Play compatibility tool and select XIVLauncher.Core from the dropdown menu.

If you choose to use the included Proton options, I *strongly* recommend setting a delay on Dalamud injection. It will almost always crash if it's set to 0. I've found 5000 ms to work fine.

There are a few differences between this build and the standard XIVLauncher.Core flatpak.

1. The GamePath will **always** be set by Steam. So wherever steam wants to install (or has installed) FFXIV will automatically be used. You can find the path by checking the ~/.xlcore/logs/steamenv.log file after running the launcher once (you don't have to run the game). Search for the line STEAM_COMPAT_INSTALL_PATH=. If you've already downloaded to ~/.xlcore or some other location, you'll have to move it back or link it.

    Examples to move/link the game:

    `mv ~/.xlcore/ffxiv "~/.local/share/Steam/steamapps/common/FINAL FANTASY XIV Online"`

    `ln -s ~/.xlcore/ffxiv "/run/media/mmcblk0p1/SteamLibrary/steamapps/common/FINAL FANTASY XIV Online"`

    Note that you have to put "quotes" around the path if it contains spaces, as above. 

2. There's now the option to use Proton instead of the managed wine install. In XIVLauncher, go to Settings > Wine, and change Installation Type to Proton. If you have any Proton libraries installed, you'll get a pair of pulldown menus for Proton Version and Steam Container Runtime. I strongly recommend running the game at least once with Proton 7.0 before trying to use GE-Proton or any other custom proton. It seems to prevent Dalamud crashes.

    For the Steam Container runtime, you'll probably only have soldier, but sniper also works. You can disable the runtime as well, but this is not recommended and may cause unexpected issues.

    DXVK ASYNC does nothing for Valve's proton libs, and only works for GE-Proton 7-44 and earlier.

    As mentioned about, set a delay on Dalamud injection, or disable it. It *will* crash about 75% of the time if you don't set a delay.

3. There is now a Troubleshooting tab in the Settings menu. This has some buttons to clear wine and proton prefixes, xlcore compatibilitytools folder, dalamud plugins, and log files, as well as generate a tspack.

4. I have done all the compiling in an Ubuntu 20.04 container. Hopefully that will allow this to run on just about anything modern. aria2c is included in the `bin/` directory in case it's not installed on the user's system. It's taken from Ubuntu 20.04, and a copy of the GPL 2.0 license is included (as aria2 uses that license). Source code can be found at https://github.com/aria2/aria2

5. I recommend downloading the `sniper` runtime. From the terminal, run `steam steam://install/1070560`. Alternately, go to your Steam Library, and search for "sniper". Install the "Steam Linux Runtime - Sniper." Then from XIVLauncher-SCT, go to Settings -> Wine, set Installation Type to Proton, and Steam Container Runtime to "SteamLinuxRuntime_sniper". I've found it to be more stable than `soldier` in my testing.

6. **IMPORTANT** If you use Proton with a Runtime, it will take 5+ seconds for the ffxiv window to appear after logging in. There's nothing I can do about this; that's how long it takes for the runtime to set up. You usually don't notice because there's a Steam window that says "Preparing to launch ..." which doesn't appear when using this tool.

## Troubleshooting

This is early-release software and may not be particularly stable. I've added a couple of logfiles to help with debugging. There's also a troubleshooting tab in the Settings menu. This has buttons to delete the wine and proton prefixes, as well as dalamud files and log files. You can also try launching without dalamud, or (if using Proton) try running it with the sniper runtime or no runtime at all.

1. You will find a console output logfile at `~/xivlauncher-sct_steamconsole.log`. This file will contain output from XIVLauncher's console log. This might let you see errors that don't get caught by XIVLauncher's internal logging. It's not in the `~/.xlcore/logs` folder because that folder might not exist when you first launch the tool, which would cause the whole script to immediately crash with no errors or logs.

2. There's an environment variable logfile at `~/.xlcore/logs/steamenv.log`. This file contains all the environment variables that are active when XIVLauncher.Core starts up.

3. The launcher will add a line to `~/.xlcore/logs/launcher.log` to indicate it is running as a Steam Compatibility Tool. It *can* be run in a standalone mode if you want, in which case that line won't be present. But if you just want a standalone launcher, use the official one.

4. Don't go to the official XIVLauncher discord for help. Make an issue on my github repo, and I'll try to check it out when I get the chance.