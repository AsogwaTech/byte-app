import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<dynamic> showAlertMessage(
    {required String messageType,
    required BuildContext context,
    Widget body = const SizedBox.shrink(),
    required String title}) {
  FocusScope.of(context).requestFocus(FocusNode());
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: getScreen(context).width * .75,
            // height: getScreen(context).height * .344,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(_getMessageIcon(messageType)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 25,
                  ),
                  width: double.infinity,
                  color: _getMessageBackground(messageType),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _getMessageText(messageType),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                     body
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                _getMessageText(messageType)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    color: _getMessageText(messageType)),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close'.toUpperCase(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _getMessageIcon(String messageType) {
  if (messageType == 'WARNING') {
    return 'assets/svg/warning.svg';
  }
  if (messageType == 'ERROR') {
    return 'assets/svg/error.svg';
  }
  if (messageType == 'SUCCESS') {
    return 'assets/svg/success.svg';
  }
  return 'assets/svg/error.svg';

}

Color? _getMessageBackground(String messageType) {
  if (messageType == 'WARNING') {
    return const Color.fromRGBO(232, 167, 0, 0.09);
  }
  if (messageType == 'ERROR') {
    return const Color.fromRGBO(188, 35, 0, 0.07);
  }
  if (messageType == 'SUCCESS') {
    return const Color.fromRGBO(12, 137, 32, 0.09);
  }
  return const Color.fromRGBO(188, 35, 0, 0.07);

}

Color _getMessageText(String messageType) {
  if (messageType == 'WARNING') {
    return const Color(0xffE8AA0B);
  }
  if (messageType == 'ERROR') {
    return const Color.fromRGBO(188, 35, 0, 1);
  }
  if (messageType == 'SUCCESS') {
    return const Color(0xFF0C8920);
  }
  return const Color(0xffE8AA0B);
}
