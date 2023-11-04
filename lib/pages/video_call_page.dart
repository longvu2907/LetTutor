import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Caller camera
        Container(
          color: Colors.black,
        ),

        // Your camera
        Positioned(
          top: 50,
          right: 5,
          child: Container(
            height: 200,
            width: 125,
            color: Colors.grey,
          ),
        ),

        // Video controller
        Positioned(
          bottom: 50,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _IconButton(
                    onPressed: () {},
                    icon: Icons.mic,
                  ),
                  _IconButton(
                    onPressed: () {},
                    icon: Icons.volume_up,
                  ),
                  _IconButton(
                    onPressed: () {},
                    icon: Icons.videocam_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: Icons.call_end,
                    bgColor: Colors.red,
                    iconColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final double iconSize;
  final IconData icon;
  final void Function() onPressed;

  const _IconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 35,
    this.bgColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        iconColor: MaterialStateProperty.all(iconColor),
        iconSize: MaterialStateProperty.all(iconSize),
      ),
    );
  }
}
