#!/bin/bash
# ADB "Address already in use" xatosini tuzatish
# Terminalda: bash fix_adb.sh

echo "5037 portni band qilgan jarayonlarni to'xtatish..."
lsof -ti :5037 | xargs kill -9 2>/dev/null
sleep 2

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

echo "ADB serverni ishga tushirish..."
adb kill-server 2>/dev/null
sleep 1
adb start-server

if [ $? -eq 0 ]; then
  echo "ADB ishlayapti. Endi: flutter run -d android"
else
  echo "Yana xato bo'lsa: Android Studio ni yopib, qayta oching yoki kompyuterni qayta ishga tushiring."
fi
