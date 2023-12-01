import 'package:flutter/material.dart';
import 'package:lettutor/models/setting.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Setting setting = context.watch<Setting>();

    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Dark mode", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                width: 10,
              ),
              Switch(
                value: setting.isDarkMode,
                onChanged: (value) {
                  setState(() {
                    setting.setDarkMode(value);
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Language:", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                width: 10,
              ),
              DropdownButton<String>(
                value: setting.language,
                elevation: 16,
                onChanged: (value) {
                  setState(() {
                    setting.setLanguage(value!);
                  });
                },
                items: [
                  "English",
                  "Vietnamese",
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
