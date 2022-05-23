import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// @author Gibah Joseph
/// email: gibahjoe@gmail.com
/// Nov, 2020

const Color appOrange = Color(0xFF0D3B66);
const Color appPrimaryColor = appOrange;
const Color appGreen = Color(0xFF4CAF50);
const Color appBackgroundGradLight = Color(0xFFF0F4FF);
const Color appBackgroundGradDark = Color(0xFFEFF3FE);
// const cropperConfig = CropperConfig(
//   aspectRatioPresets: [
//     CropAspectRatioPreset.square,
//     CropAspectRatioPreset.ratio3x2,
//     CropAspectRatioPreset.original,
//     CropAspectRatioPreset.ratio4x3,
//     CropAspectRatioPreset.ratio16x9
//   ],
//   androidUiSettings: AndroidUiSettings(
//       toolbarTitle: 'Edit image',
//       toolbarColor: appGreen,
//       toolbarWidgetColor: Colors.white,
//       initAspectRatio: CropAspectRatioPreset.original,
//       lockAspectRatio: false),
//   iosUiSettings: IOSUiSettings(title: 'Edit Image'),
// );

const inputFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: appPrimaryColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: appPrimaryColor,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black12,
    ),
  ),
  errorBorder: OutlineInputBorder(
    gapPadding: 2,
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedErrorBorder: OutlineInputBorder(
    gapPadding: 2,
    borderSide: BorderSide(color: Colors.red),
  ),
);
var formSpacer = const SizedBox(
  height: 20,
);
BaseOptions options = BaseOptions(
  baseUrl: AppConfig.baseUrl,
  followRedirects: true,
  connectTimeout: 100000,
  receiveTimeout: 30000,
);

var headerInterceptor = HeaderInterceptor();
var etraApi = Api(
  dio: Dio(options),
  serializers: (serializers.toBuilder()
        ..add(NigeriaIso8601DateTimeSerializer())
        ..addPlugin(StandardJsonPlugin()))
      .build(),
  interceptors: [
    ApiKeyAuthInterceptor(),
    if (true)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    headerInterceptor
    // HttpFormatter(includeResponseBody: true),
  ],
);

class AppConfig {
  static late String baseUrl;
}

class HeaderInterceptor extends Interceptor {
  Map<String, String?> additionalHeaders = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(additionalHeaders);
    super.onRequest(options, handler);
  }
}

class NigeriaIso8601DateTimeSerializer
    implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    return dateTime.toIso8601String();
  }

  @override
  DateTime deserialize(Serializers serializers, Object? serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return DateTime.parse(serialized as String);
  }
}
