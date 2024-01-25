import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/services/auth.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/outlined_icon_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String? bottomText;
  final String? navigateTo;
  final String? navigateToText;
  final Widget child;
  final _googleSignIn = GoogleSignIn();

  AuthLayout({
    super.key,
    required this.title,
    this.bottomText,
    this.navigateTo,
    this.navigateToText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
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
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                'Become fluent faster through one on one video chat lessons tailored to your goals.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 40),

              // Form
              child,

              // Or login with vendor

              navigateToText != null
                  ? Text(
                      'Or continue with',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : Container(),
              const SizedBox(height: 10),
              navigateToText != null
                  ? Wrap(
                      children: [
                        OutlinedIconButton(
                          icon: MdiIcons.facebook,
                          onPressed: () => _onFacebookTap(context),
                        ),
                        OutlinedIconButton(
                          icon: MdiIcons.google,
                          onPressed: () => _onGoogleTap(context),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 20),

              // Register
              navigateToText != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$bottomText ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateTo(context);
                          },
                          child: Text(
                            navigateToText ?? '',
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
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      navigateTo ?? '',
      (route) => false,
    );
  }

  void _onGoogleTap(BuildContext context) async {
    try {
      var authData = context.read<Auth>();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;

      if (accessToken != null) {
        try {
          Auth auth = await loginByGoogle(
            accessToken: accessToken,
          );

          authData.setAuth(auth);
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Login with Google: ${e.toString()}')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login with Google: ${e.toString()}')),
      );
    }
  }

  void _onFacebookTap(BuildContext context) async {
    var authData = context.read<Auth>();
    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken!.token;
      try {
        if (accessToken != null) {
          try {
            Auth auth = await loginByFacebook(
              accessToken: accessToken,
            );
            authData.setAuth(auth);
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error Login with Google: ${e.toString()}')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Login with Google: ${e.toString()}')),
        );
      }
    }
  }
}
