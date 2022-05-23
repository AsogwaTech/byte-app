import 'package:built_collection/built_collection.dart';
import 'package:api/api.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:etra_flutter/widgets/required_or_validator.dart';

// import 'package:eckopay_api/eckopay_api.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

extension StringExtension on String {
  String titleCase() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  bool toBool() {
    return toLowerCase() == 'true' || toLowerCase() == 'yes';
  }

  String get initials => split(' ')
      .map((e) => e.substring(0, 1).toUpperCase())
      .fold('', (previousValue, element) => '$previousValue$element');
}

extension IterableExtension<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapWithIndex<T>(T Function(E item, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndex(void Function(E item, int index) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension BuiltListExtension on BuiltList {
  // T? deserialize<T>(dynamic value) {
  //   var serializerForType = standardSerializers.serializerForType(T);
  //   return standardSerializers.deserializeWith<T>(serializerForType, value);
  // }
  //
  // BuiltList<T> deserializeListOf<T>(dynamic value) =>
  //     BuiltList.from(
  //         value.map((value) => deserialize<T>(value)).toList(growable: false));
}

// extension PdfPointExtension on pdf.PdfPoint {
//   /// The lesser of the magnitudes of the [x] and the [y].
//   double get shortestSide => math.min(x.abs(), y.abs());
//
//   /// The greater of the magnitudes of the [x] and the [y].
//   double get longestSide => math.max(x.abs(), y.abs());
//
//   pdf.PdfPoint fromSize(Size size) {
//     return pdf.PdfPoint(size.width, size.height);
//   }
//
//   Size toSize() {
//     return Size(x, y);
//   }
// }

// extension PdfGraphicsExtension on pdf.PdfGraphics {
//   void drawRectFromRect(Rect rect, Paint paint) {
//     assert(_rectIsValid(rect));
//     assert(paint != null); // ignore: unnecessary_null_comparison
//     this
//       ..setLineWidth(paint.strokeWidth)
//       ..setStrokeColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..setFillColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..drawRect(rect.left, rect.top, rect.width, rect.height)
//       ..closePath();
//     if (paint.style == PaintingStyle.fill) {
//       fillPath();
//     } else {
//       strokePath();
//     }
//   }
//
//   void drawImageRect(pdf.PdfImage image, Rect src, Rect dst, Paint paint) {
//     drawImage(image, dst.left, dst.top, dst.width, dst.height);
//     closePath();
//   }
//
//   void drawRRectFromRect(Rect rect, BorderRadius radius, Paint paint) {
//     var left = rect.left;
//     var top = rect.top;
//     var width = rect.width;
//     var height = rect.height;
//     this
//       ..setFillColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..setStrokeColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..setLineWidth(paint.strokeWidth)
//       ..moveTo(left + radius.topLeft.x, top)
//       ..lineTo(left + width - radius.topRight.x, top)
//       ..curveTo(left + width - radius.topRight.x, top, left + width, top,
//           left + width, top + radius.topRight.y)
//       ..lineTo(left + width, top + height - radius.bottomRight.y)
//       ..curveTo(left + width, top + height - radius.bottomRight.y, left + width,
//           top + height, left + width - radius.bottomRight.x, top + height)
//       ..lineTo(left + radius.bottomLeft.x, top + height)
//       ..curveTo(left + radius.bottomLeft.x, top + height, left, top + height,
//           left, top + height - radius.bottomLeft.y)
//       ..lineTo(left, top + radius.topLeft.y)
//       ..curveTo(
//           left, top + radius.topLeft.y, left, top, left + radius.topLeft.x, top)
//       ..closePath();
//     if (paint.style == PaintingStyle.fill) {
//       fillPath();
//     } else {
//       strokePath();
//     }
//   }
//
//   void drawRRectFromRRect(RRect rRect, Paint paint) {
//     this
//       ..setLineWidth(paint.strokeWidth)
//       ..setStrokeColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..setFillColor(pdf.PdfColor.fromInt(paint.color.value))
//       ..drawRRect(
//           rRect.left,
//           rRect.top,
//           rRect.width,
//           rRect.height,
//           rRect.tlRadius.y > rRect.height / 2
//               ? rRect.height / 2
//               : rRect.tlRadius.y,
//           rRect.tlRadius.x > rRect.width / 2
//               ? rRect.width / 2
//               : rRect.tlRadius.x)
//       ..closePath();
//     if (paint.style == PaintingStyle.fill) {
//       fillPath();
//     } else {
//       strokePath();
//     }
//   }
//
//   bool _rectIsValid(Rect rect) {
//     assert(rect != null,
//         'Rect argument was null.'); // ignore: unnecessary_null_comparison
//     assert(!rect.hasNaN, 'Rect argument contained a NaN value.');
//     return true;
//   }
// }

extension ColorExtension on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// extension QrImageExtension on QrImage {
//   PdfQrPainter toPdfQrPainter(
//       String data, int qrVersion, int errorCorrectionLevel) {
//     return PdfQrPainter(
//       data: data,
//       version: qrVersion,
//       errorCorrectionLevel: errorCorrectionLevel,
//       dataModuleStyle: dataModuleStyle,
//       blendEmbeddedImage: blendEmbeddedImage,
//       embeddedImageStyle: embeddedImageStyle,
//       eyeStyle: eyeStyle,
//     );
//   }
// }

// extension AddressExtension on Address {
//   String toAddressString([bool titleCase = true]) {
//     return [
//       houseNumber,
//       street,
//       city?.name,
//       city?.state?.name,
//       city?.state?.country?.name
//     ]
//         .where((element) => element != null && element.isNotEmpty)
//         .map((e) => e.titleCase())
//         .join(', ');
//   }
// }
//
// extension AddressPojoExtension on AddressPojo {
//   String toAddressString([bool titleCase = true]) {
//     return [houseNumber, streetAddress, city?.name, state?.name, country?.name]
//         .where((element) => element != null && element.isNotEmpty)
//         .map((e) => e.titleCase())
//         .join(', ');
//   }
// }
extension ValidationMessageExtension on ValidationMessage {
  static const String requiredOr = 'requiredOr';
}

extension ValidatorsExtension on Validators {
  static ValidatorFunction requiredOr(List<String> controlNames) =>
      RequiredOrValidator(controlNames).validate;
}

extension AppUserProfilePojoExtension on AppUserProfilePojo {
  AppUserData toAppUser() {
    return AppUserData(
        id: -1,
        name: "$firstName $lastName",
        phoneNumber: phoneNumber,
        //dateOfBirth:dateOfBirth,
        email: email,
        token: accessToken);
  }

  get fullName {
    return [firstName, lastName]
        .where((element) => element?.isNotEmpty ?? false)
        .join(' ');
  }
}

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
