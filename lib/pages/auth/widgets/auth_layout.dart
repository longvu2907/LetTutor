import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/outlined_icon_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String bottomText;
  final String navigateTo;
  final String navigateToText;
  final Widget child;

  const AuthLayout({
    super.key,
    required this.title,
    required this.bottomText,
    required this.navigateTo,
    required this.navigateToText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // hide back button
        title: SvgPicture.asset(
          'assets/icons/logo.svg',
          width: 150,
        ),
      ),
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
                  'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 40),

                // Form
                child,

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
                      onPressed: _onFacebookTap,
                    ),
                    OutlinedIconButton(
                      icon: MdiIcons.google,
                      onPressed: _onGoogleTap,
                    ),
                    OutlinedIconButton(
                      icon: Icons.phone_android,
                      onPressed: _onPhoneTap,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register
                Row(
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
                        navigateToText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }

  void _navigateTo(context) {
    Navigator.pushNamed(context, navigateTo);
  }

  void _onPhoneTap() {
    print('phone');
  }

  void _onGoogleTap() {
    print('google');
  }

  void _onFacebookTap() {
    print('facebook');
  }
}
