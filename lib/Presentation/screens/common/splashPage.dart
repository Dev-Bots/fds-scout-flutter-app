import 'dart:io';

import 'package:dev_scout_fds/Bloc/bloc.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';
import 'package:dev_scout_fds/Presentation/screens/auth/login.dart';
import 'package:dev_scout_fds/Presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final repo = EventRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const CustomDrawer(),
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leadingWidth: 20,
        //   title: CustomTitle('Football Drafting System'),
        //   iconTheme: const IconThemeData(color: Colors.black),
        // ),
        body: BlocProvider(
      // create: (context) => EventBloc(repo)..add(GetEvent(eventId: eventId)),
      create: (context) => AuthBloc()..add(CheckAuth()),
      child: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is IsAuthenticated) {
              Navigator.pushNamed(context, '/home');
            } else if (state is IsNotAuthenticated) {
              Navigator.pushNamed(context, '/login');
            }
          },
          child: Column(
            children: [
              SizedBox(height: 20.0),
              LogoImage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    ));
  }
}
