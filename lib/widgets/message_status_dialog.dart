import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageStatusDialog extends StatelessWidget {
  final String message;
  final String title;
  final bool success;
  final BoxConstraints? constraints;
  final List<Widget>? actions;

  const MessageStatusDialog({
    Key? key,
    required this.message,
    this.constraints,
    required this.success,
    this.actions,
    this.title = 'Success',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              success ? FontAwesomeIcons.check : FontAwesomeIcons.times,
              color: success ? Colors.green : Colors.red,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      actions: actions,
    );
  }
}

Future showErrorMessage(String message, BuildContext context,
    {List<Widget>? actions, bool barrierDismissible = true}) {
  return showCupertinoModalPopup(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return MessageStatusDialog(
        success: false,
        message: message,
        actions: actions,
      );
    },
  );
}

Future showSuccessMessage(String message, BuildContext context,
    [List<Widget>? actions]) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return MessageStatusDialog(
        success: true,
        message: message,
        actions: actions,
      );
    },
  );
}

Future showConfirm(String message, BuildContext context,
    {String negativeButtonText = 'Cancel',
    String positiveButtonText = 'OK',
    Function()? negativeButtonPressed,
    Function()? positiveButtonPressed}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return MessageStatusDialog(
        success: true,
        message: message,
        actions: [
          TextButton(
            onPressed: negativeButtonPressed,
            child: Text(negativeButtonText),
          ),
          ElevatedButton(
              onPressed: positiveButtonPressed, child: Text(positiveButtonText))
        ],
      );
    },
  );
}
