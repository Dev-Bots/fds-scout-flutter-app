import 'dart:convert';
import 'dart:io';
import 'package:dev_scout_fds/Bloc/bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:dev_scout_fds/Data/provider/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../Data/provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _ProfilePageState extends State<ProfilePage> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  FormBuilderLocalizations get formBuilderLocalizations =>
      FormBuilderLocalizations.of(context);

  InputDecoration formDecoration(String labelText, Icon icon) =>
      InputDecoration(
        labelText: labelText,
        // hintStyle: TextStyle(color: Colors.grey),
        icon: icon,

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // focusedBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black),
        // ),
        focusColor: Colors.black,
        iconColor: Colors.black,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      );

  var genderOptions = ['Male', 'Female'];

  var footOptions = ['Right', 'Left'];

  var educationLevelOptions = [
    'High School',
    'Degree',
    'Middle School',
    'Vocational'
  ];

  var positionOptions = ['Goalkeeper', 'Defender', 'Midfielder', 'Striker'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    formBuilderLocalizations;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        // title: const Padding(
        //   padding: EdgeInsets.only(left: 40),
        //   child: Text(
        //     'Profile',
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: LogoutButton(),
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountBloc()..add(GetMyLocalAccount()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AccountLocalLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: <Widget>[
                              // Profile Image
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.23),
                                child: Container(
                                  child: FormBuilderImagePicker(
                                    name: 'profile_image',
                                    displayCustomType: (obj) =>
                                        obj is ApiImage ? obj.imageUrl : obj,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Pick your profile picture'),
                                    maxImages: 1,
                                    initialValue: [
                                      ApiImage(
                                        id: 'whatever',
                                        imageUrl:
                                            'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //Username
                              const SizedBox(height: 20.0),
                              FormBuilderTextField(
                                name: 'username',

                                decoration: formDecoration(
                                    'Username', Icon(Icons.person)),
                                onChanged: _onChanged,
                                initialValue: state.user.userName,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(3),
                                  FormBuilderValidators.maxLength(20),
                                  FormBuilderValidators.match(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}//$'),
                                ]),
                              ),

                              //Password
                              // const SizedBox(height: 20.0),
                              // FormBuilderTextField(
                              //   name: 'password',
                              //   obscureText: true,
                              //   decoration: formDecoration(
                              //       'Password', Icon(Icons.lock)),
                              //   onChanged: _onChanged,
                              //   // valueTransformer: (text) => num.tryParse(text),
                              //   validator: FormBuilderValidators.compose([
                              //     FormBuilderValidators.required(),
                              //     FormBuilderValidators.minLength(8),
                              //     FormBuilderValidators.maxLength(20),
                              //     FormBuilderValidators.match(
                              //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'),
                              //   ]),
                              // ),

                              //Confirm Password
                              // const SizedBox(height: 20.0),
                              // FormBuilderTextField(
                              //   name: 'confirm_password',
                              //   obscureText: true,
                              //   decoration: formDecoration(
                              //       'Confirm Password', Icon(Icons.lock)),
                              //   onChanged: _onChanged,
                              //   // valueTransformer: (text) => num.tryParse(text),
                              //   validator: FormBuilderValidators.compose([
                              //     FormBuilderValidators.required(),
                              //     FormBuilderValidators.minLength(8),
                              //     FormBuilderValidators.maxLength(20),
                              //     FormBuilderValidators.match(
                              //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$'),
                              //   ]),
                              // ),

                              // First Name
                              const SizedBox(height: 20.0),
                              FormBuilderTextField(
                                name: 'first_name',
                                decoration: formDecoration(
                                    'First Name', Icon(Icons.person)),
                                onChanged: _onChanged,
                                initialValue: state.user.firstName,
                                enabled: false,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(3),
                                  FormBuilderValidators.maxLength(20),
                                  FormBuilderValidators.match(r'^[a-zA-Z]+$'),
                                ]),
                                keyboardType: TextInputType.name,
                              ),

                              // Last Name
                              const SizedBox(height: 20.0),
                              FormBuilderTextField(
                                  name: 'last_name',
                                  decoration: formDecoration(
                                      'Last Name', Icon(Icons.person)),
                                  onChanged: _onChanged,
                                  initialValue: state.user.lastName,
                                  enabled: false,
                                  // valueTransformer: (text) => num.tryParse(text),

                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(3),
                                    FormBuilderValidators.maxLength(20),
                                    FormBuilderValidators.match(r'^[a-zA-Z]+$'),
                                  ]),
                                  keyboardType: TextInputType.name),

                              // Phone Number
                              const SizedBox(height: 20.0),
                              FormBuilderTextField(
                                  name: 'phone_number',
                                  decoration: formDecoration(
                                      'Phone Number', Icon(Icons.phone)),
                                  onChanged: _onChanged,
                                  initialValue: state.user.phoneNumber,

                                  // valueTransformer: (text) => num.tryParse(text),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(10),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.match(r'^[0-9]+$'),
                                  ]),
                                  keyboardType: TextInputType.phone),

                              // Address
                              const SizedBox(height: 20.0),
                              FormBuilderTextField(
                                  name: 'address',
                                  decoration: formDecoration(
                                      'Address', Icon(Icons.home_work_sharp)),
                                  onChanged: _onChanged,
                                  initialValue: state.user.address,
                                  // valueTransformer: (text) => num.tryParse(text),
                                  validator: FormBuilderValidators.compose([
                                    // FormBuilderValidators.required(),

                                    FormBuilderValidators.match(
                                        r'^[a-zA-Z0-9]+$'),
                                  ]),
                                  keyboardType: TextInputType.text),

                              // GENDER
                              const SizedBox(height: 20.0),
                              SizedBox(height: 10.0),
                              FormBuilderDropdown(
                                name: 'gender',
                                enabled: false,
                                decoration: formDecoration(
                                    'Select Gender', Icon(Icons.man)),
                                // initialValue: state.user.,
                                allowClear: true,
                                // onChanged: null,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required()]),
                                items: genderOptions
                                    .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(''),
                                        ))
                                    .toList(),
                              ),

                              // Birthdate
                              const SizedBox(height: 30.0),
                              FormBuilderDateTimePicker(
                                name: 'dob',
                                onChanged: _onChanged,
                                inputType: InputType.date,

                                decoration: formDecoration(
                                    'Birth Date', Icon(Icons.calendar_today)),
                                format: DateFormat('yyyy-MM-dd'),
                                // initialValue: DateTime.now(),
                                // enabled: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                onPressed: () async {
                                  _formKey.currentState!.save();

                                  AuthDataProvider authDataProvider =
                                      AuthDataProvider();
                                  final token = await authDataProvider
                                      .getLocalAccessToken();

                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  final user = prefs.getString('user');
                                  final accountID = jsonDecode(user!)['id'];

                                  var request = http.MultipartRequest(
                                      'Patch',
                                      Uri.parse(
                                          'http://$baseURL/api/scouts/$accountID/'));
                                  request.headers.addAll(
                                      {"Authorization": "Bearer $token"});

                                  if (_formKey.currentState!
                                      .fields['profile_image']!.value[0]) {
                                    request.files.add(
                                        await http.MultipartFile.fromPath(
                                            'profile_picture',
                                            _formKey
                                                .currentState!
                                                .fields['profile_image']!
                                                .value[0]
                                                .path));
                                  }

                                  request.fields['username'] = _formKey
                                      .currentState!.fields['username']!.value;
                                  request.fields['phone_number'] = _formKey
                                      .currentState!
                                      .fields['phone_number']!
                                      .value;
                                  request.fields['username'] = _formKey
                                      .currentState!.fields['username']!.value;
                                  request.fields['address'] = _formKey
                                      .currentState!.fields['address']!.value;
                                  print(request.files);
                                  print(request.fields);
                                  var response = await request.send();
                                },
                                child: const Text("Update Account"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Center(child: Text('Account Loading Failed'));
            },
          ),
        ),
      ),
    );
  }
}

// ======================= Logout Button ========================

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              final authBloc = BlocProvider.of<AuthBloc>(context);

              authBloc.add(Logout());
            },
            child: const Text("Logout"),
          );
        },
      ),
    );
  }
}
