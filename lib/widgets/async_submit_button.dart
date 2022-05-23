import 'package:etra_flutter/app_config.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AsyncSubmitButton extends StatefulWidget {
  final Widget child;
  final Future Function()? onPressed;
  final String progressText;
  final TextStyle progressTextStyle;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  AsyncSubmitButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.progressText = 'Loading...',
    this.progressTextStyle = const TextStyle(),
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(
          key: key,
        );

  @override
  _AsyncSubmitButtonState createState() => _AsyncSubmitButtonState();
}

class _AsyncSubmitButtonState extends State<AsyncSubmitButton>
    with SingleTickerProviderStateMixin {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // elevation: MaterialStateProperty.all<double>(0),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.all<Color>(appPrimaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: appPrimaryColor),
          ),
        ),
      ),
      child: _loading
          ? FadingText(
              widget.progressText,
              style: widget.progressTextStyle,
            )
          : widget.child,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      focusNode: widget.focusNode,
      onLongPress: widget.onLongPress,
      onPressed: () {
        if (_loading) {
          return;
        }
        setState(() {
          _loading = true;
        });
        widget.onPressed?.call().whenComplete(() {
          setState(() {
            _loading = false;
          });
        });
      },
    );
  }
}
