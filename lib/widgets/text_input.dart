import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInput extends StatefulWidget {
  final String name;
  final String labelText;
  final String? Function(String?)? validator;
  final double? width;
  final bool isPasswordField;
  final void Function(String?)? onChange;
  final String? initialValue;
  final bool disabled;
  final int? maxLines;
  final bool isNumberField;

  const TextInput({
    super.key,
    required this.name,
    required this.labelText,
    this.onChange,
    this.validator,
    this.width,
    this.isPasswordField = false,
    this.initialValue,
    this.disabled = false,
    this.maxLines,
    this.isNumberField = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: FormBuilderTextField(
        onChanged: widget.onChange,
        name: widget.name,
        textInputAction: widget.maxLines == null ? TextInputAction.next : null,
        validator: widget.validator,
        obscureText: !_passwordVisible,
        initialValue: widget.initialValue ?? '',
        enabled: !widget.disabled,
        maxLines: widget.maxLines ?? 1,
        minLines: 1,
        keyboardType:
            widget.isNumberField ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
