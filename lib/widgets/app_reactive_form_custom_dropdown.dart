import 'package:etra_flutter/extension/extensions.dart';
import 'package:etra_flutter/widgets/app_reactive_form_field.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AsyncReactiveDropdown<I, V> extends ReactiveFormField<V, V> {
  final Future<List<I>> Function(Map<String, dynamic> params) itemSource;
  final String Function(I item, int index)? itemNameSource;
  final V Function(I item, int index)? itemValueSource;
  final bool fetchItemsOnLoad;

  /// The form control whose value this dropdown is dependent on.
  ///
  /// If this is set, this dropdown will automatically watch for value changes on the form control
  final String? parentFormControlName;
  final ValueChanged<dynamic>? parentControlValueChanged;

  AsyncReactiveDropdown(
    this.itemSource, {
    Key? key,
    String? formControlName,
    FormControl<V>? formControl,
    this.itemNameSource,
    this.itemValueSource,
    TextStyle itemNameSourceStyle = const TextStyle(),
    this.parentFormControlName,
    this.parentControlValueChanged,
    this.fetchItemsOnLoad = false,
    Map<String, String> validationMessages = const {},
    ShowErrorsFunction? showErrors,
    // DropdownButtonBuilder selectedItemBuilder,
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
    bool isExpanded = true,
    bool readOnly = false,
    double? itemHeight,
    ValueChanged<V>? onChanged,
  }) : super(
          key: key,
          formControlName: formControlName,
          formControl: formControl,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          showErrors: showErrors,
          builder: (field) {
            var state = (field as AsyncReactiveDropdownState<I, V>);
            var items = state.items
                .mapWithIndex(
                  (e, index) => DropdownMenuItem<V>(
                    value: itemValueSource?.call(e, index),
                    child: Container(
                        child: Text('${itemNameSource?.call(e, index)}')),
                  ),
                )
                .toList();
            DropdownButtonBuilder selectedItemBuilder = (context) {
              return state.items
                  .mapWithIndex(
                    (e, i) => Container(
                      child: Text(
                        itemNameSource?.call(e, i) ?? '',
                        style: itemNameSourceStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList();
            };
            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            V? effectiveValue = field.value;
            if (effectiveValue != null &&
                !items.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            final isDisabled = (readOnly || field.control.disabled);
            var effectiveDisabledHint = disabledHint;
            if (isDisabled && disabledHint == null) {
              final selectedItemIndex =
                  items.indexWhere((item) => item.value == effectiveValue);
              if (selectedItemIndex != null && selectedItemIndex > -1) {
                effectiveDisabledHint = selectedItemBuilder != null
                    ? selectedItemBuilder(field.context)
                        .elementAt(selectedItemIndex)
                    : items.elementAt(selectedItemIndex).child;
              }
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: !isDisabled,
                  ),
                  isEmpty: effectiveValue == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<V>(
                      value: effectiveValue,
                      items: items,
                      selectedItemBuilder: selectedItemBuilder,
                      hint: hint,
                      onChanged: isDisabled
                          ? null
                          : (V? value) => state._onChanged(value!, onChanged),
                      onTap: onTap,
                      disabledHint: effectiveDisabledHint,
                      elevation: elevation,
                      style: style,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconDisabledColor: iconDisabledColor,
                      iconEnabledColor: iconEnabledColor,
                      iconSize: iconSize,
                      isDense: isDense,
                      isExpanded: isExpanded,
                      itemHeight: itemHeight,
                      focusNode: state._focusController.focusNode,
                    ),
                  ),
                ),
                Visibility(
                    visible: state._fetchingItems,
                    child: FadingText('loading...'))
              ],
            );
          },
        );

  @override
  ReactiveFormFieldState<V, V> createState() {
    // TODO: implement createState
    return AsyncReactiveDropdownState<I, V>();
  }
}

class AsyncReactiveDropdownState<I, V> extends ReactiveFormFieldState<V, V> {
  List<I> items = [];
  bool _fetchingItems = false;
  late FormGroup formControl;
  FocusController _focusController = FocusController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var asyncReactiveDropdown = (widget as AsyncReactiveDropdown);
      if (asyncReactiveDropdown.fetchItemsOnLoad) {
        fetchItems();
      }
      if (asyncReactiveDropdown.parentFormControlName?.isNotEmpty ?? false) {
        formControl
            .control(asyncReactiveDropdown.parentFormControlName!)
            .valueChanges
            .listen(
          (event) {
            asyncReactiveDropdown.parentControlValueChanged?.call(event);
            fetchItems();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    formControl = ReactiveForm.of(context) as FormGroup;
    return super.build(context);
  }

  @override
  void subscribeControl() {
    this.control.registerFocusController(_focusController);
    super.subscribeControl();
  }

  @override
  void dispose() {
    this.control.unregisterFocusController(_focusController);
    _focusController.dispose();
    super.dispose();
  }

  void fetchItems() {
    print('----- FETCH ITEMS');
    setState(() {
      _fetchingItems = true;
    });
    (widget as AsyncReactiveDropdown)
        .itemSource
        .call(formControl.value)
        .then((value) {
      items = value as List<I>;
      setState(() {});
    }).whenComplete(() => setState(() {
              _fetchingItems = false;
            }));
  }

  void clearItems() {
    print('----- FETCH ITEMS');
    setState(() {
      items.clear();
    });
  }

  void _onChanged(V value, ValueChanged<V>? callBack) {
    didChange(value);
    if (callBack != null) {
      callBack(value);
    }
  }
}
