#!/bin/bash
# This script is for rapidly testing and rebuilding based on local repos
# Set the local repo paths for XIVLauncher.Core and FFXIVQuickLauncher in the paths.sh script.
. paths.sh
if (( $# > 0 )); then
    outname="$1"
fi
echo "Removing old builds $src $outfolder"
rm -rf $src
rm -rf $outfolder
echo "Copying $xlcore/ -> $src"
cp -r $xlcore/ $src
echo "Removing submodule files"
rm -rf $src/lib/FFXIVQuickLauncher
echo "Copying $ffql -> $src/lib/"
cp -r $ffql $src/lib/
mkdir -p $bin
cp src/* "$bin/../"
cp -r bin "$bin/.."
cp openssl_fix.cnf $bin
mkdir -p $outfolder/XIVLauncher/lib
cp lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib
ln -sr $outfolder/XIVLauncher/lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib/libsecret-1.so.0
echo "Building XIVLauncher.Core in $bin"
cd $src/src/XIVLauncher.Core || exit
dotnet publish -r linux-x64 --sc -o "$bin" --configuration Release $noWarnings -p:BuildHash="$hash"
cd "$bin/../.."
echo "Compressing to tar.gz archive..."
tar -czf $outname XIVLauncher
echo "Output file: $(pwd)/$outname"
echo "Unzip to ~/.local/share/Steam/compatibilitytools.d and restart Steam."
