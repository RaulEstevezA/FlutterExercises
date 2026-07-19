import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;


  const CustomTextFormField({
    super.key, 
    this.label, 
    this.hint, 
    this.errorMessage, 
    this.onChanged, 
    this.validator
    });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40)
    );

    return TextFormField(
      onChanged: (value) {
        print('value $value');
      },

      validator: (value) {
        if (value == null) return 'Campo requerio';
        if (value.trim().isEmpty) return 'Campo requerio';

        return null;
      },

      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),

        isDense: true,
        label: Text('Cualquier cosa'),
        hintText: 'Este es el hintText',
        errorText: 'Este es el errorText',
        focusColor: colors.primary,
      ),
    );


  }
}