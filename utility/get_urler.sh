#!/usr/bin/env bash

cd ../app

# delete old ipa if exists
if [ -e URLer.app ]; then
  rm -rf URLer.app
  echo "removed URLer.app"
fi

# copy latest built simulator version
cp -R /Users/joel8641/Library/Developer/Xcode/DerivedData/URLer-gngjafdvlxwlrdcvtixkbfnhydoy/Build/Products/Debug-iphonesimulator/URLer.app /Users/joel8641/Box\ Sync/Esri\ Material/Projects/urler-appium-test/app

# check there
if [ -e URLer.app ]; then
  echo "copied URLer.app"
else
  echo "failed to download URLer.ipa from appbuilder.esri.com"
fi

