# XIVLauncher-SCT
## XIVLauncher.Core built into a Steam Compatibility Tool

Clone the repo, then build the tool with ./build.sh. This will put a tar.gz file in the `out/` directory. Unzip that to `~/.local/share/Steam/compatibilitytools.d/`. Then restart Steam.

Open Steam, and right-click on Final Fantasy XIV. Properties > Compatibility > Force the use of a specific Steam Play compatibility tool and select XIVLauncher.Core from the dropdown menu.

There are a few differences between this build and the standard XIVLauncher.Core flatpak.

1. The GamePath will **always** be set by Steam. So wherever steam wants to install (or has installed) FFXIV will automatically be used. You can find the path by checking the ~/.xlcore/logs/steamenv.log file after running the launcher once (you don't have to run the game). Search for the line STEAM_COMPAT_INSTALL_PATH=. If you've already downloaded to ~/.xlcore or some other location, you'll have to move it back or link it.

    Examples to move/link the game:

    `mv ~/.xlcore/ffxiv "~/.local/share/Steam/steamapps/common/FINAL FANTASY XIV Online"`

    `ln -s ~/.xlcore/ffxiv "/run/media/mmcblk0p1/SteamLibrary/steamapps/common/FINAL FANTASY XIV Online"`

    Note that you have to put "quotes" around the path if it contains spaces, as above. 

2. There's now the option to use Proton instead of the managed wine install. In XIVLauncher, go to Settings > Wine, and change Installation Type to Proton. If you have any Proton libraries installed, you'll get a pair of pulldown menus for Proton Version and Steam Container Runtime. I strongly recommend running the game at least once with Proton 7.0 before trying to use GE-Proton or any other custom proton. It seems to prevent Dalamud crashes.

    For the Steam Container runtime, you'll probably only have soldier, but sniper also works. You can disable the runtime as well, but this is not recommended and may cause unexpected issues.

    DXVK ASYNC does nothing for Valve's proton libs, and only works for GE-Proton 7-44 and earlier.

3. There is now a Troubleshooting tab in the Settings menu. This has some buttons to clear wine and proton prefixes, xlcore compatibilitytools folder, dalamud plugins, and log files, as well as generate a tspack.