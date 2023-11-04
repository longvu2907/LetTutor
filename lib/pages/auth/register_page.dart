import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lettutor/pages/auth/widgets/auth_layout.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/text_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _password = '';

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Sign up',
      navigateTo: 'login',
      bottomText: 'Already have an account?',
      navigateToText: 'Log in',
      child: _registerForm(),
    );
  }

  FormBuilder _registerForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(children: [
        TextInput(
          name: 'email',
          labelText: "Email",
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const SizedBox(height: 20),
        TextInput(
          name: 'password',
          labelText: "Password",
          isPasswordField: true,
          onChange: (value) {
            setState(() {
              _password = value ?? '';
            });
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 20),
        TextInput(
          name: 'confirmPassword',
          labelText: "Confirm Password",
          isPasswordField: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.equal(
              _password,
              errorText: 'Password not match!',
            ),
          ]),
        ),
        const SizedBox(height: 25),
        Button(
          text: 'Sign up',
          onPressed: () {
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              final formData = _formKey.currentState?.value;
              print(formData);
            }
          },
          isFullWidth: true,
        ),
        const SizedBox(height: 40),
      ]),
    );
  }
}
