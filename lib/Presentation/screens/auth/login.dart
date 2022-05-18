import 'package:dev_scout_fds/Bloc/AuthBloc/auth_bloc.dart';
import 'package:dev_scout_fds/Presentation/config/routes.dart';
import 'package:dev_scout_fds/Presentation/screens/screens.dart';

import 'package:dev_scout_fds/Presentation/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:dev_scout_fds/Data/provider/provider.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

class LoginPage extends StatelessWidget {
  final repo = AuthRepository();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    // final loginBloc = BlocProvider.of<LoginBloc>(context).state;
    final inputFieldStyle = InputDecoration(
      border: OutlineInputBorder(),
    );

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      LogoImage(),
                      SizedBox(height: 20.0),
                      UsernameField(
                          usernameTextController: usernameTextController),
                      SizedBox(height: 20.0),
                      PasswordField(
                          passwordTextController: passwordTextController,
                          inputFieldStyle: inputFieldStyle),
                      SizedBox(height: 30.0),
                      StateCheckBloc(
                          formKey: formKey,
                          usernameTextController: usernameTextController,
                          passwordTextController: passwordTextController),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StateCheckBloc extends StatelessWidget {
  StateCheckBloc({
    Key? key,
    required this.usernameTextController,
    required this.passwordTextController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).state;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, loginState) {
        if (loginState is LoggingIn) {
          final snackBar = SnackBar(content: Text("Login in progress"));

          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          CircularProgressIndicator();
        }

        if (loginState is LoggedIn) {
          // buttonChild = Text(authState.errorMsg);
          // String role = loginState.user.role;
          print('WORKSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
          Navigator.of(context).pushNamed(RouteGenerator.homePage);
        }

        if (loginState is LoginFailed) {
          // buttonChild = Text(authState.errorMsg);

          final snackBar = SnackBar(content: Text(loginState.error));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (ctx, authState) {
        Widget buttonChild = Text("Login");

        return LoginButton(
            formKey: formKey,
            usernameTextController: usernameTextController,
            passwordTextController: passwordTextController,
            buttonChild: buttonChild);
      },
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(height: MediaQuery.of(context).size.height / 10),
        Container(
          width: 400,
          height: MediaQuery.of(context).size.height / 2,
          // decoration: BoxDecoration(color: Colors.black),
          child: Image.asset('assets/images/company_logo.png'),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.formKey,
    required this.usernameTextController,
    required this.passwordTextController,
    required this.buttonChild,
  }) : super(key: key);

  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;
  final Widget buttonChild;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
      onPressed: () {
        // use the information provided
        final authBloc = BlocProvider.of<AuthBloc>(context);

        authBloc.add(Login(
            username: usernameTextController.text,
            password: passwordTextController.text));
      },
      child: buttonChild,
    );
  }
}

class UsernameField extends StatelessWidget with InputValidationMixin {
  const UsernameField({
    Key? key,
    required this.usernameTextController,
  }) : super(key: key);

  final TextEditingController usernameTextController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameTextController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: "Username",
      ),
    );
  }
}

class PasswordField extends StatelessWidget with InputValidationMixin {
  const PasswordField({
    Key? key,
    required this.passwordTextController,
    required this.inputFieldStyle,
  }) : super(key: key);

  final TextEditingController passwordTextController;
  final InputDecoration inputFieldStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: passwordTextController,
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: "Password",
      ),
    );
  }
}
