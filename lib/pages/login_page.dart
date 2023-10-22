import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/outlined_icon_button.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leading: Container(
          margin: const EdgeInsets.only(left: 25),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
        ),
        leadingWidth: 175,
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 25,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  opacity: .1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Đăng nhập',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),

                  // Form
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
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _forgotPassword,
                    child: Row(
                      children: [
                        Text(
                          'Quên mật khẩu?',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Button(
                    text: 'Đăng nhập',
                    onPressed: _login,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: 20),

                  // Or login with vendor
                  Text(
                    'Hoặc tiếp tục với',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      OutlinedIconButton(
                        icon: MdiIcons.facebook,
                        onPressed: _loginWIthFacebook,
                      ),
                      OutlinedIconButton(
                        icon: MdiIcons.google,
                        onPressed: _loginWithGoogle,
                      ),
                      OutlinedIconButton(
                        icon: Icons.phone_android,
                        onPressed: _loginWithPhone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản? ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      GestureDetector(
                        onTap: _navigateToRegister,
                        child: Text(
                          'Đăng ký',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _login() {
    _formKey.currentState?.save();
    if (_formKey.currentState!.validate()) {
      final formData = _formKey.currentState?.value;
      print(formData);
    }
  }

  void _forgotPassword() {}

  void _navigateToRegister() {}

  void _loginWithPhone() {
    print('phone');
  }

  void _loginWithGoogle() {
    print('google');
  }

  void _loginWIthFacebook() {
    print('facebook');
  }
}
