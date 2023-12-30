import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/user.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/snackbar_notify.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  DateTime? _selectedDate;
  ImagePicker picker = ImagePicker();
  XFile? avatar;
  bool _isLoading = false;

  @override
  void initState() {
    _selectedDate = context.read<Auth>().user?.birthday;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? userData = context.watch<Auth>().user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Avatar
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var file =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    avatar = file;
                  });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (avatar != null
                          ? FileImage(File(avatar?.path ?? ''))
                          : NetworkImage(userData?.avatar ?? ''))
                      as ImageProvider<Object>,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            height: 1.4,
                          ),
                    ),
                    Text(
                      userData?.email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),

          // Form
          const SizedBox(height: 40),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                  name: 'name',
                  labelText: "Name",
                  initialValue: userData?.name ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'country',
                  labelText: "Country",
                  initialValue: userData?.country ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'phone',
                  labelText: "Phone Number",
                  initialValue: userData?.phone ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate != null
                          ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                          : "Date of birth"),
                    ),
                    const SizedBox(width: 10),
                    Button(
                      onPressed: () => _selectDate(context),
                      text: 'Select date',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Save button
          const SizedBox(height: 10),
          Button(
            text: 'Save',
            isFullWidth: true,
            isLoading: _isLoading,
            onPressed: () async {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                final data = _formKey.currentState?.value;

                setState(() {
                  _isLoading = true;
                });
                try {
                  var updatedUser = await updateProfile(
                      accessToken: context.read<Auth>().accessToken.toString(),
                      data: UpdateProfileRequest(
                        name: data?['name'],
                        country: data?['country'],
                        phone: data?['phone'],
                        birthDate: _selectedDate!,
                      ));

                  if (avatar != null) {
                    updatedUser = await updateAvatar(
                      accessToken: context.read<Auth>().accessToken.toString(),
                      avatar: avatar!,
                    );
                  }

                  context.read<Auth>().setUser(updatedUser);
                  ScaffoldMessenger.of(context).showSnackBar(
                    successMessage('Update profile success'),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(errorMessage(e.toString()));
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
          ),

          // Become tutor button
          const SizedBox(height: 25),
          Button(
            text: 'Become Tutor',
            isFullWidth: true,
            onPressed: () {
              Navigator.pushNamed(context, 'become-tutor');
            },
          ),

          // Setting button
          const SizedBox(height: 10),
          Button(
            text: 'Setting',
            isFullWidth: true,
            onPressed: () {
              Navigator.pushNamed(context, 'setting');
            },
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
