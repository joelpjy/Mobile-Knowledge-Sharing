#!/usr/bin/env sh

flutter pub run build_runner build --delete-conflicting-outputs
chmod +x android/gradlew
./gradlew generateEnums