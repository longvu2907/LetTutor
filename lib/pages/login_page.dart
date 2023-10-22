import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Login Page',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('hi')),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  color: Colors.red,
                );
              },
              itemCount: 10),
        ),
      ],
    );
  }
}
