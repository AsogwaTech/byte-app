import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart'
    hide PhoneNumber;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phone_number/phone_number.dart' as phone;
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config.dart';
import 'app_image_picker.dart';

final Map<String, String> globValidationMessages = {
  ValidationMessage.required: 'This field is required',
  ValidationMessage.email: 'Invalid email',
  ValidationMessage.minLength: 'Too short',
  ValidationMessage.min: 'Too short',
  ValidationMessage.maxLength: 'Too long',
  ValidationMessage.max: 'Too long',
  'Invalid format': 'Invalid Format',
  'indiregfrontnoface': 'Face is not clear on this card',
  'alreadyExists': 'Item already exists.'
};
Future<Map<String, dynamic>?> Function(AbstractControl) validatePhoneFormat =
    (e) async {
  if (e.invalid) {
    e.markAsTouched();
    return e.errors;
  }
  e.markAsUntouched();
  if (e.value == null) {
    return null;
  }
  if (e.value.length < 14) {
    e.markAsTouched();
    return <String, dynamic>{ValidationMessage.minLength: true};
  }
  if (e.value.length > 14) {
    e.markAsTouched();
    return <String, dynamic>{'maxLength': true};
  }
  try {
    var phoneNumber =
        await phone.PhoneNumberUtil().parse(e.value, regionCode: 'NG');
    print(phoneNumber);
    return null;
  } catch (ex) {
    print(ex);
    e.markAsTouched();
    return <String, dynamic>{'Invalid format': true};
  }
};

class LabeledInput extends StatelessWidget {
  LabeledInput(
      {Key? key,
        this.requiredField = false,
        required this.label,
        required this.child,
        this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        this.labelMargin =
        const EdgeInsets.symmetric(vertical: 3, horizontal: 0)})
      : super(key: key);
  final bool requiredField;
  final String label;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets labelMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: labelMargin,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                label != null
                    ? Text(label)
                    : SizedBox(
                  height: 0.0,
                ),
                requiredField
                    ? Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class AppReactiveTextInput extends ReactiveTextField {
  AppReactiveTextInput({
    Key? key,
    required String? formControlName,
    FormControl? formControl,
    Map<String, String> validationMessages = const {},
    ControlValueAccessor<dynamic, String>? valueAccessor,
    ShowErrorsFunction? showErrors,
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement maxLengthEnforcement = MaxLengthEnforcement.enforced,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    Radius? cursorRadius,
    String? hintText,
    String? labelText,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
  }) : super(
    key: key,
          formControlName: formControlName,
          formControl: formControl,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          valueAccessor: valueAccessor,
          showErrors: showErrors,
          decoration:
              decoration.copyWith(hintText: hintText, labelText: labelText),
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          style: style,
          strutStyle: strutStyle,
//          textDirection: textDirection,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          autofocus: autofocus,
          readOnly: readOnly,
          toolbarOptions: toolbarOptions,
          showCursor: showCursor,
          obscureText: obscureText,
          autocorrect: autocorrect,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          enableSuggestions: enableSuggestions,
          maxLengthEnforcement: maxLengthEnforcement,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          onTap: onTap,
          inputFormatters: inputFormatters,
          cursorWidth: cursorWidth,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          buildCounter: buildCounter,
          scrollPhysics: scrollPhysics,
          onSubmitted: onSubmitted,
        );
}

class AppReactiveDropdownInput<T> extends ReactiveDropdownField<T> {
  AppReactiveDropdownInput({
    Key? key,
    required String formControlName,
    FormControl<T>? formControl,
    required List<DropdownMenuItem<T>> items,
    Map<String, String> validationMessages = const {},
    ShowErrorsFunction? showErrors,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    VoidCallback? onTap,
    InputDecoration decoration = const InputDecoration(),
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool readOnly = false,
    double? itemHeight,
    ValueChanged<T?>? onChanged,
  }) : super(
            key: key,
            formControlName: formControlName,
            formControl: formControl,
            items: items,
            validationMessages: (e) {
              return {}
                ..addAll(globValidationMessages)
                ..addAll(validationMessages);
            },
            showErrors: showErrors,
            selectedItemBuilder: selectedItemBuilder,
            hint: hint,
            onTap: onTap,
            decoration: decoration,
            disabledHint: disabledHint,
            elevation: elevation,
            style: style,
            icon: icon,
            iconDisabledColor: iconDisabledColor,
            iconEnabledColor: iconEnabledColor,
            iconSize: iconSize,
            isDense: isDense,
            isExpanded: isExpanded,
            readOnly: readOnly,
            itemHeight: itemHeight,
            onChanged: onChanged);
}

class AppReactiveCheckBox extends ReactiveFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  AppReactiveCheckBox({
    Key? key,
    required String formControlName,
    required String label,
    FormControl<bool>? formControl,
    bool tristate = false,
    InputDecoration decoration = const InputDecoration(),
    Color activeColor = appPrimaryColor,
    Map<String, String> validationMessages = const {},
    Color checkColor = Colors.white,
    Color focusColor = appPrimaryColor,
    EdgeInsets padding = const EdgeInsets.all(0),
    Color? hoverColor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    bool autofocus = false,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          builder: (ReactiveFormFieldState<bool, bool> field) {
            return InputDecorator(
              decoration: decoration.copyWith(
                  errorText: field.errorText,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Colors.transparent,
                  enabledBorder: InputBorder.none
              ),
              child: Container(
                padding: padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text(label)),
                    Checkbox(
                      value: field.value ?? false,
                      onChanged: field.control.enabled ? field.didChange : null,
                      tristate: tristate,
                      activeColor: activeColor,
                      checkColor: checkColor,
                      focusColor: focusColor,
                      hoverColor: hoverColor,
                      materialTapTargetSize: materialTapTargetSize,
                      visualDensity: visualDensity,
                      autofocus: autofocus,
                    ),
                  ],
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<bool, bool> createState() =>
      ReactiveFormFieldState<bool, bool>();
}

class AppReactiveDateField extends ReactiveFormField<DateTime, DateTime> {
  AppReactiveDateField({
    required String formControlName,
    required DateTime firstDate,
    required DateTime initialDate,
    required DateTime lastDate,
    DateFormat? format,
    bool required = true,
    String hintText = '',
    Map<String, String> validationMessages = const {},
  }) : super(
          formControlName: formControlName,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          builder: (ReactiveFormFieldState<DateTime, DateTime> field) {
            var state = field as AppReactiveDateFieldState;
            state._textEditingController.text = (field.value) == null
                ? ''
                : (format ?? DateFormat("dd MMMM, yyyy")).format(field.value!);
            return TextFormField(
              focusNode: state._focusNode,
              controller: state._textEditingController,
              onTap: () {
                showDatePicker(
                  context: field.context,
                  initialDate: field.value ?? initialDate,
                  firstDate: firstDate,
                  lastDate: lastDate,
                  builder: (c, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                          colorScheme:
                              ColorScheme.light(primary: appPrimaryColor),
                          primaryColor: appPrimaryColor,
                          cupertinoOverrideTheme:
                              CupertinoThemeData(primaryColor: appPrimaryColor),
                          cursorColor: appPrimaryColor),
                      child: child!,
                    );
                  },
                  errorFormatText: "Invalid format. Use (MM/DD/YYYY) instead",
                  fieldLabelText: 'Enter Date (MM/DD/YYYY)',
                  fieldHintText: 'Enter Date (MM/DD/YYYY)',
                ).then((value) {
                  if (value != null) {
                    field.didChange(value);
                    state._textEditingController.text =
                        (format ?? DateFormat("dd MMMM, yyyy")).format(value);
                  }
                });
              },
              decoration: InputDecoration()
                  .copyWith(errorText: field.errorText, hintText: hintText),
            );
          },
        );

  @override
  AppReactiveDateFieldState createState() => AppReactiveDateFieldState();
}

class AppReactiveDateFieldState
    extends ReactiveFormFieldState<DateTime, DateTime> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}

class AppReactiveTimeField extends ReactiveFormField<DateTime, DateTime> {
  AppReactiveTimeField({
    required String formControlName,
    required DateTime initialTime,
    DateFormat? format,
    bool required = true,
    String hintText = '',
    Map<String, String> validationMessages = const {},
  }) : super(
          formControlName: formControlName,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          builder: (ReactiveFormFieldState<DateTime, DateTime> field) {
            var state = field as AppReactiveTimeFieldState;
            state._textEditingController.text = (field.value) == null
                ? ''
                : (format ?? (format ?? DateFormat('hh:mm a')))
                    .format(field.value!);
            return TextFormField(
              focusNode: state._focusNode,
              controller: state._textEditingController,
              onTap: () {
                showTimePicker(
                  context: field.context,
                  initialTime:
                      TimeOfDay.fromDateTime(field.value ?? initialTime),
                  builder: (c, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                          colorScheme:
                              ColorScheme.light(primary: appPrimaryColor),
                          primaryColor: appPrimaryColor,
                          cupertinoOverrideTheme:
                              CupertinoThemeData(primaryColor: appPrimaryColor),
                          cursorColor: appPrimaryColor),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    var dateTime = new DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        value.hour,
                        value.minute);
                    field.didChange(dateTime);
                    state._textEditingController.text =
                        (format ?? (format ?? DateFormat('hh:mm a')))
                            .format(dateTime);
                  }
                });
              },
              decoration: InputDecoration()
                  .copyWith(errorText: field.errorText, hintText: hintText),
            );
          },
        );

  @override
  AppReactiveTimeFieldState createState() => AppReactiveTimeFieldState();
}

class AppReactiveTimeFieldState
    extends ReactiveFormFieldState<DateTime, DateTime> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}

class AppReactivePhoneNumberField extends ReactiveFormField<String, String> {
  AppReactivePhoneNumberField({
    Key? key,
    SelectorConfig? selectorConfig,
    ValueChanged<PhoneNumber>? onInputChanged,
    ValueChanged<bool>? onInputValidated,
    VoidCallback? onSubmit,
    ValueChanged<String>? onFieldSubmitted,
    String Function(String)? validator,
    Function(String)? onSaved,
    TextEditingController? textFieldController,
    TextInputAction? keyboardAction,
    PhoneNumber? initialValue,
    String? hintText,
    String? errorMessage,
    double? selectorButtonOnErrorPadding,
    int? maxLength,
    bool? isEnabled,
    bool? formatInput,
    bool? autoFocus,
    bool? autoFocusSearch,
    AutovalidateMode? autoValidateMode,
    bool? ignoreBlank,
    bool? countrySelectorScrollControlled,
    String? locale,
    TextStyle? textStyle,
    TextStyle? selectorTextStyle,
    InputBorder? inputBorder,
    InputDecoration inputDecoration = const InputDecoration(),
    InputDecoration? searchBoxDecoration,
    FocusNode? focusNode,
    List<String>? countries,
    required String formControlName,
    FormControl<String>? formControl,
    Map<String, String> validationMessages = const {},
    ControlValueAccessor<String, String>? valueAccessor,
    ShowErrorsFunction? showErrors,
    EdgeInsets labelPadding = const EdgeInsets.only(bottom: 8),
    bool requiredField = false,
    String? label,
  }) : super(
            key: key,
            formControl: formControl,
            formControlName: formControlName,
            valueAccessor: valueAccessor,
            validationMessages: (e) {
              return {}
                ..addAll(globValidationMessages)
                ..addAll(validationMessages);
            },
            showErrors: showErrors,
            builder: (field) {
              final state = field as _AppReactivePhoneNumberField;
              final effectiveDecoration = inputDecoration
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme);
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(primary: appPrimaryColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (e) async {
                          // try {
                          //   var phoneNumber = await phone.PhoneNumberUtil()
                          //       .parse(e.phoneNumber, regionCode: 'NG');
                          field.didChange(e.phoneNumber);
                          // } catch (ex) {
                          //   field.didChange(null);
                          // }
                        },
                        hintText: hintText,
                        textFieldController: state._textController,
                        focusNode: state._focusController.focusNode,
                        errorMessage: field.errorText,
                        initialValue: initialValue,
                        countries: ['NG'],
                        formatInput: true,
                        spaceBetweenSelectorAndTextField: 0,
                        selectorTextStyle: null,
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                            setSelectorButtonAsPrefixIcon: true,
                            leadingPadding: 5,
                            showFlags: false),
                        inputDecoration: effectiveDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.transparent,
                            errorText: state.errorText,
                            hintText: hintText),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var contact =
                            await FlutterContactPicker.pickPhoneContact(
                                askForPermission: true);
                        try {
                          if (contact.phoneNumber?.number != null) {
                            var phoneNumber =
                                await PhoneNumber.getRegionInfoFromPhoneNumber(
                                    contact.phoneNumber?.number ?? '', 'NG');
                            field.didChange(phoneNumber.phoneNumber);
                            state._textController.text = phoneNumber.phoneNumber
                                    ?.replaceAll(
                                        '+${phoneNumber.dialCode}', '') ??
                                '';
                          } else {
                            field.didChange(null);
                            state._textController.text = '';
                          }
                        } catch (ex) {
                          print(ex);
                        }
                      },
                      child: Center(
                        child: Tooltip(
                          message: 'Select from contacts',
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     right: BorderSide(
                            //       color: Colors.black12,
                            //     ),
                            //   ),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.contacts_rounded,
                                  color: Color(0xff6177C3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });

  @override
  ReactiveFormFieldState<String, String> createState() {
    return _AppReactivePhoneNumberField();
  }
}

class _AppReactivePhoneNumberField
    extends ReactiveFormFieldState<String, String> {
  late TextEditingController _textController;
  late FocusController _focusController;

  FocusNode get focusNode => _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    _textController = TextEditingController(text: '');
    if (_textController.text.isNotEmpty)
      await PhoneNumber.getRegionInfoFromPhoneNumber(value ?? '', 'NG')
          .then((value) {
        _textController.text =
            value.phoneNumber?.replaceAll('+${value.dialCode}', '') ?? '';
      }).catchError((error) {
        print(error);
      });
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    String effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<String, String> selectValueAccessor() {
    return super.selectValueAccessor();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    this.control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    this.control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }
}

// var pinNormalTheme = const PinTheme.defaults(
//     shape: PinCodeFieldShape.underline,
//     inactiveColor: appPrimaryColor,
//     selectedColor: appPrimaryColor,
//     activeColor: appPrimaryColor);
// var pinErrorTheme = const PinTheme.defaults(
//     shape: PinCodeFieldShape.underline,
//     inactiveColor: Colors.red,
//     selectedColor: Colors.red,
//     activeColor: Colors.red);

// class AppReactivePINField extends ReactiveFormField<String, String> {
//   AppReactivePINField({
//     Key? key,
//     int length = 6,
//     required BuildContext context,
//     required String formControlName,
//     FormControl<String>? formControl,
//     Map<String, String> validationMessages = const {},
//     ControlValueAccessor<String, String>? valueAccessor,
//     AutovalidateMode? autoValidateMode,
//     ShowErrorsFunction? showErrors,
//     TextInputType keyboardType = TextInputType.number,
//     PinTheme pinTheme = const PinTheme.defaults(
//         shape: PinCodeFieldShape.box,
//         inactiveColor: appPrimaryColor,
//         selectedColor: appPrimaryColor,
//         activeColor: appPrimaryColor),
//   }) : super(
//             key: key,
//             formControl: formControl,
//             formControlName: formControlName,
//             valueAccessor: valueAccessor,
//             validationMessages: (e) {
//               return {}
//                 ..addAll(globValidationMessages)
//                 ..addAll(validationMessages);
//             },
//             showErrors: showErrors,
//             builder: (field) {
//               final state = field as _AppReactivePINFieldState;
//               final effectiveDecoration = const InputDecoration()
//                   .applyDefaults(Theme.of(state.context).inputDecorationTheme);
//               return InputDecorator(
//                 decoration: effectiveDecoration.copyWith(
//                     errorText: state.errorText,
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     contentPadding: EdgeInsets.zero),
//                 child: PinCodeTextField(
//                   onChanged: (e) {
//                     field.didChange(e);
//                   },
//                   length: length,
//                   appContext: context,
//                   focusNode: state._focusController.focusNode,
//                   validator: (v) {
//                     return state.errorText;
//                   },
//                   pinTheme: (state.errorText?.isEmpty ?? true)
//                       ? pinNormalTheme
//                       : pinErrorTheme,
//                   animationType: AnimationType.fade,
//                   autovalidateMode: AutovalidateMode.disabled,
//                   keyboardType: keyboardType,
//                 ),
//               );
//             });
//
//   @override
//   ReactiveFormFieldState<String, String> createState() {
//     return _AppReactivePINFieldState();
//   }
// }
//
// class _AppReactivePINFieldState extends ReactiveFormFieldState<String, String> {
//   late TextEditingController _textController;
//   late FocusController _focusController;
//
//   FocusNode get focusNode => _focusController.focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void subscribeControl() {
//     _registerFocusController(FocusController());
//     super.subscribeControl();
//   }
//
//   @override
//   void unsubscribeControl() {
//     _unregisterFocusController();
//     super.unsubscribeControl();
//   }
//
//   @override
//   void onControlValueChanged(dynamic value) {
//     String effectiveValue = (value == null) ? '' : value.toString();
//     _textController.value = _textController.value.copyWith(
//       text: effectiveValue,
//       selection: TextSelection.collapsed(offset: effectiveValue.length),
//       composing: TextRange.empty,
//     );
//
//     super.onControlValueChanged(value);
//   }
//
//   // @override
//   // ControlValueAccessor selectValueAccessor() {
//   //   if (this.control is FormControl<int>) {
//   //     return IntValueAccessor();
//   //   } else if (this.control is FormControl<double>) {
//   //     return DoubleValueAccessor();
//   //   } else if (this.control is FormControl<DateTime>) {
//   //     return DateTimeValueAccessor();
//   //   } else if (this.control is FormControl<TimeOfDay>) {
//   //     return TimeOfDayValueAccessor();
//   //   }
//   //
//   //   return super.selectValueAccessor();
//   // }
//
//   void _registerFocusController(FocusController focusController) {
//     _focusController = focusController;
//     this.control.registerFocusController(focusController);
//   }
//
//   void _unregisterFocusController() {
//     this.control.unregisterFocusController(_focusController);
//     _focusController.dispose();
//   }
// }

class AppReactiveImageField extends ReactiveFormField<File, File> {
  AppReactiveImageField({
    Key? key,
    bool cropAfterSelection = false,
    required String formControlName,
    required CropperConfig cropperConfig,
    ShowErrorsFunction? showErrors,
    Map<String, String> validationMessages = const {},
    BoxFit fit = BoxFit.cover,
    Function? onTap,
    File? initialValue,
    Widget placeHolder = const Icon(
      Icons.add_a_photo_outlined,
    ),
    double? width,
    double? height,
    InputDecoration inputDecoration = const InputDecoration(),
    Widget loading = const SizedBox.shrink(),
    EdgeInsets padding = const EdgeInsets.all(10),
  }) : super(
          formControlName: formControlName,
          key: key,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          showErrors: showErrors,
          builder: (field) {
            return InkWell(
              onTap: () {
                selectImage(field.context, (f) {
                  field.didChange(f);
                },
                    cropperConfig: cropperConfig,
                    cropAfterSelection: cropAfterSelection);
              },
              child: InputDecorator(
                decoration:
                    (inputDecoration).copyWith(errorText: field.errorText),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: padding,
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      child: field.value == null
                          ? placeHolder
                          : Image.file(
                              field.value!,
                              fit: fit,
                            ),
                    ),
                    ReactiveStatusListenableBuilder(
                      formControlName: formControlName,
                      builder: (context, control, child) {
                        return control.pending
                            ? loading // progress indicator if status is 'pending'
                            : Container(width: 0);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );

  static FutureBuilder getImageViewFromPickedFile(PickedFile pickedFile) {
    return FutureBuilder(
      future: pickedFile.readAsBytes(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        return Image.memory(snapshot.data);
      },
    );
  }
}

class AppReactiveFieldDecorator<T> extends ReactiveFormField<T, T> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  AppReactiveFieldDecorator({
    Key? key,
    required String formControlName,
    FormControl<T>? formControl,
    Map<String, String> validationMessages = const {},
    EdgeInsets padding = const EdgeInsets.only(top: 8, bottom: 8),
    InputDecoration decoration = const InputDecoration(),
    required Widget child,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          builder: (ReactiveFormFieldState<T, T> field) {
            return InputDecorator(
              decoration: decoration.copyWith(
                  errorText: field.errorText, contentPadding: padding),
              child: child,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}

// class AppReactiveRatingInput extends ReactiveFormField<double, double> {
//   AppReactiveRatingInput({
//     required String formControlName,
//     required Widget Function(BuildContext, int) itemBuilder,
//     double initialRating = 0,
//     double minRating = 1,
//     Axis direction = Axis.horizontal,
//     bool allowHalfRating = true,
//     int itemCount = 5,
//     double itemSize = 25,
//     EdgeInsets itemPadding = const EdgeInsets.symmetric(horizontal: 1.0),
//     String hintText = 'Enter Date of Birth',
//     Map<String, String> validationMessages = const {},
//   }) : super(
//           formControlName: formControlName,
//           validationMessages: (e) {
//             return {}
//               ..addAll(globValidationMessages)
//               ..addAll(validationMessages);
//           },
//           builder: (ReactiveFormFieldState<double, double> field) {
//             var state = field;
//             return InputDecorator(
//               decoration: InputDecoration(
//                   errorText: state.errorText,
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   contentPadding: EdgeInsets.zero),
//               child: RatingBar.builder(
//                 initialRating: state.value ?? initialRating,
//                 minRating: minRating,
//                 direction: direction,
//                 allowHalfRating: allowHalfRating,
//                 itemCount: itemCount,
//                 itemSize: itemSize,
//                 itemPadding: itemPadding,
//                 itemBuilder: itemBuilder,
//                 onRatingUpdate: (rating) {
//                   state.didChange(rating);
//                 },
//               ),
//             );
//           },
//         );
//
//   @override
//   ReactiveFormFieldState<double, double> createState() =>
//       ReactiveFormFieldState();
// }

class AppReactiveCurrencyField extends ReactiveFormField<double, String> {
  AppReactiveCurrencyField({
    Key? key,
    required String formControlName,
    Map<String, String> validationMessages = const {},
    ControlValueAccessor<dynamic, String>? valueAccessor,
    ShowErrorsFunction? showErrors,
    required Widget prefix,
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    FocusNode? focusNode,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement maxLengthEnforcement = MaxLengthEnforcement.enforced,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    Radius? cursorRadius,
    String? hintText,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
  }) : super(
            key: key,
            builder: (state) {
              var fieldState = (state as AppReactiveCurrencyFieldState);
              final effectiveDecoration = decoration
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme);
              fieldState._setFocusNode(focusNode);
              return TextField(
                controller: state._textController,
                focusNode: state.focusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: fieldState.errorText,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      prefix,
                    ],
                  ),
                ),
                inputFormatters: [fieldState._formatter],
                onChanged: (v) {
                  fieldState.didChange(v);
                },
              );
            },
            formControlName: formControlName,
            validationMessages: (e) {
              return {}
                ..addAll(globValidationMessages)
                ..addAll(validationMessages);
            });

  @override
  AppReactiveCurrencyFieldState createState() =>
      AppReactiveCurrencyFieldState();
}

class AppReactiveCurrencyFieldState
    extends ReactiveFormFieldState<double, String> {
  late TextEditingController _textController;
  late FocusController _focusController;
  FocusNode? _focusNode;
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(decimalDigits: 2, symbol: '');

  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _textController = TextEditingController();
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    String effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<double, String> selectValueAccessor() {
    //   if (this.control is FormControl<int>) {
    //     return IntValueAccessor();
    //   } else if (this.control is FormControl<double>) {
    return CurrencyValueAccessor();
    //   } else if (this.control is FormControl<DateTime>) {
    //     return DateTimeValueAccessor();
    //   } else if (this.control is FormControl<TimeOfDay>) {
    //     return TimeOfDayValueAccessor();
    //   }
    //
    //   return super.selectValueAccessor();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    this.control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    this.control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}

class CurrencyValueAccessor extends ControlValueAccessor<double, String> {
  final int fractionDigits;

  CurrencyValueAccessor({
    this.fractionDigits = 2,
  });

  @override
  String modelToViewValue(double? modelValue) {
    return modelValue == null ? '' : modelValue.toStringAsFixed(fractionDigits);
  }

  @override
  double? viewToModelValue(String? viewValue) {
    return (viewValue == '' || viewValue == null)
        ? null
        : double.tryParse(viewValue.replaceAll(',', ''));
  }
}
