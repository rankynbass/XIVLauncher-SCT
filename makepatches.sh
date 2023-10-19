#!/bin/bash
rootfolder="$(dirname $(realpath $0))"
# commit for current XIVLauncher.Core release
corecommit=072aca4
# submodule commit for current XIVLauncher.Core release
libcommit=e8e22c3
cd $rootfolder/XIVLauncher.Core
git diff --binary $corecommit xlcore-sct -- src/ > $rootfolder/patches/XIVLauncher-SCT-src.patch
cd lib/FFXIVQuickLauncher
git diff $libcommit compatibility-rework-2-proton > $rootfolder/patches/XIVLauncher-SCT-lib.patch