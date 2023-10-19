#!/bin/bash
cd $(dirname $(realpath $0))
. paths.sh

if (( $# > 0 )); then
    outname="$1"
fi

echo "Building from official XIVLauncher.Core repo and patchset"
echo "Removing old builds $src $outfolder"
rm -rf $src
rm -rf $outfolder
git clone https://github.com/goatcorp/XIVLauncher.Core.git --branch $upstream --single-branch --recurse-submodules $src
cd $src
git apply $rootfolder/patches/XIVLauncher-SCT-src.patch
cd lib/FFXIVQuickLauncher
git apply $rootfolder/patches/XIVLauncher-SCT-lib.patch
git checkout -b SCT
git add .
git commit -m "Add XIVLauncher-SCT patch"
cd ../..
git checkout -b SCT
git add .
git commit -m "Add XIVLauncher-SCT patch"
hash=$(git rev-parse --short HEAD)
cd $rootfolder
mkdir -p $bin
cp src/* "$bin/../"
cp -r bin "$bin/.."
cp openssl_fix.cnf $bin
mkdir -p $outfolder/XIVLauncher/lib
cp lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib
ln -sr $outfolder/XIVLauncher/lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib/libsecret-1.so.0
echo "Building XIVLauncher.Core in $bin"
cd $src/src/XIVLauncher.Core || exit
dotnet publish -r linux-x64 --sc -o "$bin" --configuration Release $noWarnings -p:BuildHash="$hash-$upstream-patched"
cd "$bin/../.."
echo "Compressing to tar.gz archive..."
tar -czf $outname XIVLauncher
echo "Output file: $(pwd)/$outname"
echo "Unzip to ~/.local/share/Steam/compatibilitytools.d and restart Steam."