import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double? size;

  const Rating({
    super.key,
    required this.rating,
    this.size,
  });

  List<Widget> starList() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(ValueFilledIcon(
        icon: Icons.star,
        color: Colors.yellow.shade700,
        value: rating - i,
        size: size,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: starList(),
    );
  }
}

class ValueFilledIcon extends StatelessWidget {
  final double value;
  final Color color;
  final IconData icon;
  final double? size;

  const ValueFilledIcon({
    super.key,
    required this.value,
    required this.color,
    required this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, value, value],
          colors: [color, color, color.withOpacity(0)],
        ).createShader(rect);
      },
      child: Icon(icon, size: size, color: Colors.grey[300]),
    );
  }
}
