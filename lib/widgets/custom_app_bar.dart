import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false, // hide back button
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'login');
          },
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(Icons.logout),
          ),
        ),
      ],
      title: SvgPicture.asset(
        'assets/icons/logo.svg',
        width: 125,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
