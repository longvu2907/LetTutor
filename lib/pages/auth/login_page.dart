import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lettutor/pages/auth/widgets/auth_layout.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Login',
      navigateTo: 'register',
      bottomText: 'Not a member yet?',
      navigateToText: 'Sign up',
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
            FormBuilderValidators.required(
                errorText: 'Please input your Email!'),
            FormBuilderValidators.email(errorText: 'Email not valid!'),
          ]),
        ),
        const SizedBox(height: 20),
        TextInput(
          name: 'password',
          labelText: "Password",
          isPasswordField: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Please input your Password!'),
          ]),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Button(
          text: 'Login',
          onPressed: _login,
          isFullWidth: true,
        ),
        const SizedBox(height: 40),
      ]),
    );
  }

  void _login() {
    _formKey.currentState?.save();
    if (_formKey.currentState!.validate()) {
      final formData = _formKey.currentState?.value;
      Navigator.pushNamedAndRemoveUntil(
        context,
        'home',
        (route) => false,
      );
    }
  }
}
