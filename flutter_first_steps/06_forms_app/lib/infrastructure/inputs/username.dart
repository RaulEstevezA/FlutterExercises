import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, NameInputError> {
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}