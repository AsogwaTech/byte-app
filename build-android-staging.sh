#! /bin/bash

flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs

flutter -v build apk lib/main_staging.dart
