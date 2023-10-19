#!/bin/bash
export rootfolder="$(dirname $(realpath $0))"
export src=/tmp/xlcore-src
export outfolder="$rootfolder/out"
export bin="$rootfolder/out/XIVLauncher/xlcore-bin"
export xlcore=$HOME/projects/XIVLauncher.Core
export ffql=$HOME/projects/FFXIVQuickLauncher
# use -clp:ErrorsOnly to turn off warnings. Comment out to enable warnings.
export noWarnings=-clp:ErrorsOnly
# Name of output file.
export ver=$(cat $rootfolder/version.txt)
export outname=XIVLauncher-SCT-$ver.tar.gz
export upstream=1.0.6