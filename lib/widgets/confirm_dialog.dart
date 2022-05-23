import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Jul, 2021
 **/
class ConfirmDialog extends StatefulWidget {
  final String titleText;
  final String body;

  // final VoidCallback? onPositiveButtonPressed;
  // final VoidCallback? onNegativeButtonPressed;
  final String positiveButtonText;
  final String negativeButtonText;

  ConfirmDialog(
      {Key? key,
      this.titleText = 'Confirm',
      required this.body,
      // this.onPositiveButtonPressed,
      // this.onNegativeButtonPressed,
      this.positiveButtonText = 'CONTINUE',
      this.negativeButtonText = 'CANCEL'})
      : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        widget.titleText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
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
            style: TextStyle(
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
            },
            child: Text(widget.positiveButtonText),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(widget.negativeButtonText),
          ),
        ),
      ],
    );
  }
}

Future<T?> confirm<T>(
    {required BuildContext context,
    Color barrierColor = kCupertinoModalBarrierColor,
    bool barrierDismissible = true,
    String? titleText,
    required String body,
    // VoidCallback? onPositiveButtonPressed,
    // VoidCallback? onNegativeButtonPressed,
    String positiveButtonText = 'CONTINUE',
    String negativeButtonText = 'CANCEL'}) {
  return showCupertinoModalPopup<T>(
      context: context,
      builder: (_) {
        return ConfirmDialog(
          body: body,
          // onNegativeButtonPressed: onNegativeButtonPressed,
          // onPositiveButtonPressed: onPositiveButtonPressed,
          positiveButtonText: positiveButtonText,
          negativeButtonText: negativeButtonText,
        );
      });
}
