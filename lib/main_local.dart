import 'dart:io';

import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/main.dart';

void main() {
  if (Platform.isAndroid) {
    AppConfig.baseUrl = 'http://10.0.2.2:9080';
  } else {
    AppConfig.baseUrl = 'http://localhost:9080';
  }
  init();
}
