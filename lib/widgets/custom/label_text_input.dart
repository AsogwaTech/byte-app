import 'package:etra_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../app_reactive_form_field.dart';

class LabelTextInput extends StatefulWidget {
  final String label;
  final Widget? leadingLabel;
  final Map<String, String> validationMessages;
  final String formControlName;
  final String? hint;
  final TextInputType keyboardType;
  final bool disabled;
  final bool obscureText;

  LabelTextInput(
      {required this.formControlName,
      required this.label,
      this.leadingLabel,
      required this.validationMessages,
      this.disabled = false,
        this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.hint});

  @override
  _LabelTextInput createState() => _LabelTextInput();
}

class _LabelTextInput extends State<LabelTextInput> {
  @override
  Widget build(BuildContext context) {
    return LabeledInput(
      label: widget.label,
      child: AppReactiveTextInput(
        readOnly: widget.disabled,
        obscureText: widget.obscureText,
        decoration: inputFieldDecoration.copyWith(
          errorStyle: TextStyle(fontSize: 10, height: .7),
          prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 45),
          isDense: true,
          prefixIcon: isNotNull(widget.leadingLabel)
              ? Container(
                  margin: EdgeInsets.only(right: 4),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: widget.leadingLabel,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
        validationMessages: {}..addAll(widget.validationMessages),
        formControlName: widget.formControlName,
        keyboardType: widget.keyboardType,
        hintText: isNotNull(widget.hint) ? widget.hint : '',
      ),
    );
  }
}
