#!/bin/bash
export src=/tmp/xlcore-src
export outfolder="$(dirname $(realpath $0))/out"
export bin="$(dirname $(realpath $0))/out/XIVLauncher/xlcore-bin"
export xlcore=$HOME/projects/XIVLauncher.Core
export ffql=$HOME/projects/FFXIVQuickLauncher
# use -clp:ErrorsOnly to turn off warnings. Comment out to enable warnings.
export noWarnings=-clp:ErrorsOnly
# Name of output file.
export ver=0.2.0
export rel=alpha.1
export hash=$rel
export outname=XIVLauncher-SCT-$ver-$rel.tar.gz