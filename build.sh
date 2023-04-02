#!/bin/bash
. paths.sh
echo "Removing old build $bin"
rm -rf "$bin"
mkdir -p "$bin"
cp openssl_fix.cnf "$bin"
cp src/* "$bin/../"
echo "Building XIVLauncher.Core in $bin"
cd XIVLauncher.Core/src/XIVLauncher.Core || exit
dotnet publish -r linux-x64 --sc -o "$bin" --configuration Release $noWarnings -p:BuildHash="$hash"
cd "$bin/../.."
echo "Compressing to tar.gz archive..."
tar -czf $outname XIVLauncher
echo "Output file: $(pwd)/$outname"
echo "Unzip to ~/.local/share/Steam/compatibilitytools.d and restart Steam."
