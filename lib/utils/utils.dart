import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_info/device_info.dart';

import 'package:dio/dio.dart';
import '../app_config.dart';

String getApiCallResponseMessage(dynamic error, String defaultMessage) {
  if (error is DioError) {
    if (error.response?.data is Map) {
      return error.response?.data['message'] ?? defaultMessage;
    }
  }
  return defaultMessage;
}

bool isNull(dynamic obj) {
  return obj == null;
}

bool isNotNull(dynamic obj) {
  return !isNull(obj);
}

Size getScreen(BuildContext context) {
  return MediaQuery.of(context).size;
}

bool isTablet(BuildContext context) {
  var size = getScreen(context);
  return (size.shortestSide > 600);
}


String toFullName(List<String> names) {
  return names.where((value) => value != null && value.isNotEmpty).join(' ');
}

String plural(int length, String single, String plural) {
  return length < 2 ? single : plural;
}

PrettyDioLogger getPrettyDioLogger() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 100,
  );
}


// Future<BwFile> uploadImage(File file) async {
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('${AppConfig.baseUrl}/files/upload'));
//   var pic = await http.MultipartFile.fromPath('file', file.path);
//   request.files.add(pic);
//   var response = await request.send();
//   var responseData = await response.stream.toBytes();
//   return BwFile.fromJson(jsonDecode(String.fromCharCodes(responseData)));
// }


String launchFormat(LAUNCHER type, String value) {
  if (type == LAUNCHER.PHONE) {
    return 'tel:$value';
  } else if (type == LAUNCHER.EMAIL) {
    return 'mailto:$value';
  } else if (type == LAUNCHER.URL) {
    return value.contains('http') ? value : 'http://$value';
  } else {
    return value;
  }
}

Future<bool> saveToken(String token) async {
  var instance = await getSharedPreferences();
  return instance.setString('token', token);
}


Future<String?> getToken() async {
  var instance = await getSharedPreferences();
  return instance.getString('token');
}

Future<SharedPreferences> getSharedPreferences() async{
  return SharedPreferences.getInstance();
}

String formatDate(DateTime date, String format) {
  final formatter = DateFormat(format);
  return formatter.format(date);
}

enum LAUNCHER { PHONE, EMAIL, URL }


String toTitleCase(String str) {
  if (isNull(str)) {
    return str;
  }
  return '${str[0].toUpperCase()}${str.substring(1, str.length)}';
}

void showToast(BuildContext context, String message,
    {int durationInSeconds = 1}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold
    ..removeCurrentSnackBar
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: durationInSeconds),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
              ),
            ),
          ],
        ),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
}

Future endAsync() {
  return Future.value([]);
}

String getImageUrl(int imageId) {
  return '${AppConfig.baseUrl}/files/${imageId.toString()}';
}

Future<SharedPreferences> getSharedPreference() {
  return SharedPreferences.getInstance();
}



double degreesToRadians(degrees) {
  return degrees * math.pi / 180;
}

double distanceInKmCoordinates(double lat1, double lon1, double lat2, double lon2) {
  var earthRadiusKm = 6371;
  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);
  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);
  var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.sin(dLon / 2) * math.sin(dLon / 2) * math.cos(lat1) * math.cos(lat2);
  var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return earthRadiusKm * c;
}

class BwFile {
  String fileName;
  String contentType;
  int fileId;
  int size;

  BwFile.fromJson(Map json)
      : fileName = json['fileName'],
        contentType = json['contentType'],
        fileId = json['fileId'],
        size = json['size'];
}


String toNaira(num amount) {
  return NumberFormat.currency(
    decimalDigits: 2,
    symbol: '₦',
  ).format(amount);
}

Future<String> getOsVersion() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.version.release;
  } else {
    var androidDeviceInfo = await deviceInfo.iosInfo;
    return androidDeviceInfo.systemVersion;
  }
}

Future<String> getModelName() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    return 'Apple';
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.model;
  }
}


Future<String> getBrandName() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.manufacturer;
  } else {
    var androidDeviceInfo = await deviceInfo.iosInfo;
    return androidDeviceInfo.model;
  }
}



