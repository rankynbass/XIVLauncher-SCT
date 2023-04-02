#!/bin/bash
export src=/tmp/xlcore-src
export bin="$(dirname $(realpath $0))/out/XIVLauncher/xlcore-bin"
export outname=XIVLauncher-SteamCompatibilityTool.tar.gz
export xlcore=$HOME/projects/XIVLauncher.Core
export ffql=$HOME/projects/FFXIVQuickLauncher
export ver=1.0.3.0
export hash=Steam-Compatibility-Tool
export coreRepo=https://github.com/rankynbass/XIVLauncher.Core.git
export coreTag=steamcompattool
export ffqlRepo=https://github.com/rankynbass/FFXIVQuickLauncher.git
export ffqlTag=steamcompattool
# use -clp:ErrorsOnly to turn off warnings. Comment out to enable warnings.
export noWarnings=-clp:ErrorsOnly
