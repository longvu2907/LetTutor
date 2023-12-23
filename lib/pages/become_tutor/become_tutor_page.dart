import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/country.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:provider/provider.dart';

final targetStudentList = [
  "Beginner",
  "Intermediate",
  "Advanced",
];

final specialties = [
  "English for kids",
  "Business English",
  "Conversational",
  "STARTERS",
  "MOVERS",
  "FLYERS",
  "KET",
  "PET",
  "IELTS",
  "TOEFL",
  "TOEIC",
];

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({super.key});

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  ImagePicker picker = ImagePicker();
  String? _countryCode;
  String? _languageCode;
  DateTime selectedDate = DateTime.now();
  String? _targetStudent;
  final List<bool> _specialties = List.filled(specialties.length, false);

  @override
  Widget build(BuildContext context) {
    User? userData = context.watch<Auth>().user;

    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(
                title: 'Set up your tutor profile',
                subtitle:
                    "Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.\nNew students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.",
              ),
              const SizedBox(height: 20),

              // Basic info
              Text(
                "Basic info",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => picker.pickImage(source: ImageSource.gallery),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData?.avatar ?? ''),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TextInput(
                name: 'name',
                labelText: "Tutoring name",
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _countryCode,
                elevation: 16,
                hint: const Text("Country"),
                onChanged: (v) {
                  setState(() {
                    _countryCode = v;
                  });
                },
                isExpanded: true,
                items: countryList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value["code"],
                    child: Text(value["name"]!),
                  );
                }).toList(),
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(selectedDate.toString().substring(0, 10) !=
                            DateTime.now().toString().substring(0, 10)
                        ? DateFormat('dd MMM yyyy').format(selectedDate)
                        : "Date of birth"),
                  ),
                  const SizedBox(width: 10),
                  Button(
                    onPressed: () => _selectDate(context),
                    text: 'Select date',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // CV
              Text(
                "CV",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              const TextInput(
                name: 'interests',
                labelText: "Interests",
                maxLines: 5,
              ),
              const SizedBox(height: 10),

              const TextInput(
                name: 'education',
                labelText: "Education",
              ),
              const SizedBox(height: 10),

              const TextInput(
                name: 'experience',
                labelText: "Experience",
              ),
              const SizedBox(height: 10),

              const TextInput(
                name: 'profession',
                labelText: "Current or Previous Profession",
              ),
              const SizedBox(height: 25),

              // Languages I speak
              Text(
                "Languages I speak",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _languageCode,
                elevation: 16,
                hint: const Text("Language"),
                onChanged: (v) {
                  setState(() {
                    _languageCode = v;
                  });
                },
                isExpanded: true,
                items: countryList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value["code"],
                    child: Text(value["name"]!),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),

              // Who I teach
              Text(
                "Who I teach",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              const TextInput(
                name: 'introduction',
                labelText: "Introduction",
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              const Text("I am best at teaching students who are"),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(targetStudentList[index]),
                    value: targetStudentList[index].toLowerCase(),
                    groupValue: _targetStudent,
                    onChanged: (String? value) {
                      setState(() {
                        _targetStudent = value;
                      });
                    },
                  );
                },
                itemCount: targetStudentList.length,
              ),
              const SizedBox(height: 10),
              const Text("My specialties are"),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: _specialties[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _specialties[index] = value!;
                      });
                    },
                    title: Text(specialties[index]),
                  );
                },
                itemCount: specialties.length,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
