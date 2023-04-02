#!/bin/bash
# Meant to be run in an Ubuntu 20.04 container, which is what I use for compiling this.
# This script will generate a list of *.so files to be put in the lib folder. Needed as fallback
# in case the user doesn't have these libraries installed. It would probably be better to create a custom runtime,
# but I haven't figured out how to do that yet.
declare -a depends=("build-essential" "aria2" "libsdl2-2.0-0" "libsecret-1-0" "attr" "fontconfig" "liblcms2-2" "libxml2" "libxcursor1" "libxrandr2" "libxdamage1" "gettext" "libfreetype6" "libglu1-mesa" "libsm6" "libpcap0.8" "libfaudio0" "desktop-file-utils" "libjxr0" "xdg-utils")

sudo apt install -y "${depends[@]}"

declare -a libs

for dep in "${depends[@]}"
do
    for file in $(dpkg --listfiles $dep | grep "\.so")
    do
        libs+=( "$file" )
    done
done

rm -f libraries
for lib in "${libs[@]}"; do echo $lib >> libraries; done

rm -f binaries
echo "/usr/bin/aria2c" >> binaries