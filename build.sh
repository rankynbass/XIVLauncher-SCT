#!/bin/bash
. paths.sh
if (( $# > 0 )); then
    outname="$1"
fi
echo $outname
echo "Removing old build $outfolder"
rm -rf "$outfolder"
mkdir -p "$bin"
cp openssl_fix.cnf "$bin"
cp src/* "$bin/../"
cp -r bin "$bin/.."
mkdir -p $outfolder/XIVLauncher/lib
cp lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib
ln -sr $outfolder/XIVLauncher/lib/libsecret-1.so.0.0.0 $outfolder/XIVLauncher/lib/libsecret-1.so.0
echo "Building XIVLauncher.Core in $bin"
cd XIVLauncher.Core/src/XIVLauncher.Core || exit
dotnet publish -r linux-x64 --sc -o "$bin" --configuration Release $noWarnings -p:Version="$ver" -p:BuildHash="$hash"
cd "$bin/../.."
echo "Compressing to tar.gz archive..."
tar -czf $outname XIVLauncher
echo "Output file: $(pwd)/$outname"
echo "Unzip to ~/.local/share/Steam/compatibilitytools.d and restart Steam."
