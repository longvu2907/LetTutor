import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInput extends StatelessWidget {
  final String name;
  final String labelText;
  final String? Function(String?)? validator;
  final double? width;
  final bool obscureText;

  const TextInput({
    super.key,
    required this.name,
    required this.labelText,
    this.validator,
    this.width,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: FormBuilderTextField(
        name: name,
        textInputAction: TextInputAction.next,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
