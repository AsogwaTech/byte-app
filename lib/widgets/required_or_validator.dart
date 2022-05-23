import 'package:etra_flutter/extension/extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that requires that any one of specified controls is required.
class RequiredOrValidator extends Validator<dynamic> {
  final List<String> controlNames;

  /// Constructs an instance of [RequiredOrValidator]
  RequiredOrValidator(this.controlNames);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessageExtension.requiredOr: true};

    if (control is! FormGroup) {
      return error;
    }

    List<AbstractControl> controls =
        controlNames.map((e) => control.control(e)).toList();
    for (var value in controls) {
      if (value.value != null) {
        removeErrors(controls);
        return null;
      }
    }
    for (var value in controls) {
      value.setErrors(error);
      // value.markAsTouched();
    }
    return null;
  }

  void removeErrors(List<AbstractControl> controls) {
    for (var value in controls) {
      value.removeError(ValidationMessageExtension.requiredOr);
    }
  }
}
