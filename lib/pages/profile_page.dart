import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    User? userData = context.watch<Auth>().user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userData?.avatar ?? ''),
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
                    Text(userData?.id ?? '')
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
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
                  name: 'email',
                  labelText: "Email",
                  disabled: true,
                  initialValue: userData?.email ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'country',
                  labelText: "Country",
                  disabled: true,
                  initialValue: userData?.country ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'phone',
                  labelText: "Phone Number",
                  disabled: true,
                  initialValue: userData?.phone ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'birthday',
                  labelText: "Birthday",
                  disabled: true,
                  initialValue: userData?.birthday.toString() ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                TextInput(
                  name: 'level',
                  labelText: "Level",
                  disabled: true,
                  initialValue: userData?.level ?? '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Button(
            text: 'Save',
            isFullWidth: true,
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                final data = _formKey.currentState?.value;

                userData?.name = data?['name'];
                context.read<Auth>().setUser(userData);
                print(data);
              }
            },
          ),
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
}
