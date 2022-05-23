import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Jul, 2021
 **/
class Alert extends StatefulWidget {
  final String titleText;
  final String body;
  final VoidCallback? onPositiveButtonPressed;
  final String positiveButtonText;

  Alert(
      {Key? key,
      this.titleText = 'Alert',
      required this.body,
      this.onPositiveButtonPressed,
      this.positiveButtonText = 'CONTINUE'})
      : super(key: key);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        widget.titleText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff666666),
              fontSize: 16,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
              widget.onPositiveButtonPressed?.call();
            },
            child: Text(widget.positiveButtonText),
          ),
        ),
      ],
    );
  }
}

Future<T?> alert<T>(
    {required BuildContext context,
    Color barrierColor = kCupertinoModalBarrierColor,
    bool barrierDismissible = true,
    String titleText = 'Alert',
    required String body,
    VoidCallback? onPositiveButtonPressed,
    String positiveButtonText = 'OK'}) {
  return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return Alert(
          body: body,
          titleText: titleText,
          onPositiveButtonPressed: onPositiveButtonPressed,
          positiveButtonText: positiveButtonText,
        );
      });
}
