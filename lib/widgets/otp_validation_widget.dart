// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:dio/dio.dart';
//
// class OtpValidationWidget extends StatefulWidget {
//   const OtpValidationWidget({
//     Key key,
//     this.autoDismiss = true,
//     @required this.deliveryMode,
//     @required this.deliveryIdentifier,
//     @required this.type,
//     @required this.onResend,
//   }) : super(key: key);
//
//   final String deliveryIdentifier;
//   final bool autoDismiss;
//   final RequestOtpDtoDeliveryModeEnum deliveryMode;
//   final RequestOtpDtoTypeEnum type;
//   final Function onResend;
//
//   @override
//   _OtpValidationWidgetState createState() => _OtpValidationWidgetState();
// }
//
// class _OtpValidationWidgetState extends State<OtpValidationWidget> {
//   FormGroup formGroup = FormGroup({
//     'pin': FormControl<String>(
//         validators: [Validators.required, Validators.number])
//   });
//   bool canResend = false;
//   Duration countDownFrom = Duration(seconds: 30);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery
//                 .of(context)
//                 .viewInsets
//                 .bottom +
//                 10, // so that the whole thing always move +10
//           ),
//           child: ReactiveForm(
//             formGroup: formGroup,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 formSpacer,
//                 Text(
//                   'Enter the OTP sent to ${widget.deliveryIdentifier}',
//                   style: TextStyle(),
//                   textScaleFactor: 1.2,
//                 ),
//                 formSpacer,
//                 formSpacer,
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: AppReactivePINField(
//                     formControlName: 'pin',
//                     context: context,
//                     keyboardType: TextInputType.number,
//                     length: 6,
//                   ),
//                 ),
//                 if (!canResend)
//                   Row(
//                     children: [
//                       Spacer(),
//                     ],
//                   ),
//                 if (canResend)
//                   Row(
//                     children: [
//                       Spacer(),
//                       Text("Didn't get it?"),
//                       InkWell(
//                           onTap: () {
//                             widget.onResend?.call();
//                             setState(() {
//                               canResend = false;
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8.0, bottom: 8.0),
//                             child: Text('Resend code'),
//                           ))
//                     ],
//                   ),
//                 formSpacer,
//                 AsyncSubmitButton(
//                   onPressed: () async {
//                     formGroup.markAllAsTouched();
//                     if (formGroup.valid) {
//                       var email = widget.deliveryMode ==
//                           RequestOtpDtoDeliveryModeEnum.EMAIL
//                           ? widget.deliveryIdentifier
//                           : null;
//                       var phone = widget.deliveryMode ==
//                           RequestOtpDtoDeliveryModeEnum.SMS
//                           ? widget.deliveryIdentifier
//                           : null;
//                       var verifyOtpDto = VerifyOtpDto((b) =>
//                       b
//                         ..type =
//                         VerifyOtpDtoTypeEnum.valueOf(widget.type.name)
//                         ..deliveryMode =
//                         VerifyOtpDtoDeliveryModeEnum.valueOf(
//                             widget.deliveryMode.name)
//                         ..requesterEmail = email
//                         ..pin = formGroup.value['pin']
//                         ..requesterPhoneNumber = phone);
//                       await securegateApi
//                           .getOneTimePasswordControllerApi()
//                           .verifyOtp(verifyOtpDto)
//                           .then((value) {
//                         Navigator.pop(context, verifyOtpDto.pin);
//                       }).catchError((v) {
//                         if (v is DioError) {
//                           if (v?.response?.statusCode != null &&
//                               v?.response?.statusCode == 400) {
//                             if (v?.response?.data is Map) {
//                               formGroup.control('pin').setErrors({
//                                 v?.response?.data['message'] ??
//                                     'Invalid Code': true
//                               });
//                               return;
//                             }
//                           }
//                         }
//                         formGroup.control('pin').setErrors({
//                           v?.response?.data['message'] ??
//                               'Could not validate. Check internet connection':
//                           true
//                         });
//                       });
//
//                       // Navigator.pop(context, verifyOtpDto.pin);
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
