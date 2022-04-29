import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final prefs = SharedPreferences.getInstance();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        emit(LoggingIn());
        await authRepository.login(event.username, event.password).then((user) {
          print('user $user');
          if (user != null) {
            emit(LoggedIn(user: user));
          } else {
            emit(LoginFailed(error: 'Login failed! Please try again.'));
          }
          // emit(LoggedIn(user: user));
        }).catchError((error) {
          if (error is Exception) {
            emit(LoginFailed(error: error.toString()));
          } else {
            emit(LoginFailed(error: 'Something went wrong'));
          }
        });
      } else if (event is Logout) {
        emit(LoggingOut());
        await authRepository.logout().then((user) {
          emit(LoggedOut());
        }).catchError((error) {
          emit(LogoutFailed(error: error));
        });
      } else if (event is RefreshToken) {
        print('Ayyyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeye');
        emit(RefreshingToken());
        await authRepository
            .refreshToken(event.refreshToken)
            .then((accessToken) {
          emit(TokenRefreshed(accessToken: accessToken));
        }).catchError((error) {
          emit(TokenRefreshFailed(error: error));
        });
      } else if (event is Register) {
        emit(Registering());
        await authRepository.register(event.account).then((user) {
          emit(LoggedIn(user: user));
        }).catchError((error) {
          emit(LoginFailed(error: error));
        });
      } else if (event is CheckAuth) {
        await Future.delayed(const Duration(seconds: 2), () {
          emit(CheckingAuth());
        });
        final isAuthenticated = await authRepository.checkAuth();
        if (isAuthenticated) {
          emit(IsAuthenticated());
        } else {
          emit(IsNotAuthenticated());
        }
      }
    });
  }
}
