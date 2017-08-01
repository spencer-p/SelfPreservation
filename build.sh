#!/bin/sh

build=`pwd`/build

# .love
rm $build/SelfPreservation.love
zip -9 $build/SelfPreservation.love -r components conf.lua entities font.png hump main.lua Md_curses_16x16.png scenes SelfPreservation.love sounds util

# macOS
cd $build
cp SelfPreservation.love SelfPreservation.app/Contents/Resources
rm $build/SelfPreservation-macOS.zip
zip -9 -y -r $build/SelfPreservation-macOS.zip SelfPreservation.app/

# windows
cd $build/Windows/love-0.10.2-win64/
cat ../love.exe $build/SelfPreservation.love > SelfPreservation.exe
chmod +x SelfPreservation.exe
rm $build/SelfPreservation-Windows64.zip
zip -9 -r $build/SelfPreservation-Windows64.zip *

