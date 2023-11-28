import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/pages/auth/widgets/auth_layout.dart';
import 'package:lettutor/services/auth.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Forgot Password',
      child: _forgotPasswordForm(),
    );
  }

  FormBuilder _forgotPasswordForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(children: [
        TextInput(
          name: 'email',
          labelText: "Email",
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Please input your Email!'),
            FormBuilderValidators.email(errorText: 'Email not valid!'),
          ]),
        ),
        const SizedBox(height: 10),
        Button(
          text: 'Send reset link',
          onPressed: _resetPassword,
          isFullWidth: true,
          isLoading: _isLoading,
        ),
        const SizedBox(height: 40),
      ]),
    );
  }

  void _resetPassword() {
    _formKey.currentState?.save();
    if (_formKey.currentState!.validate()) {
      final formData = _formKey.currentState?.value;

      print(formData);
    }
  }
}
