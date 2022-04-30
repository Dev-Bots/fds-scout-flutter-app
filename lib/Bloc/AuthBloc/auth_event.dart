part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String username;
  final String password;

  const Login({required this.username, required this.password});

  @override
  List<Object> get props => [];
}

class Logout extends AuthEvent {
  @override
  List<Object> get props => [];
}

class CheckAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Register extends AuthEvent {
  final Account account;

  const Register({required this.account});

  @override
  List<Object> get props => [account];
}

class RefreshToken extends AuthEvent {
  final String refreshToken;
  const RefreshToken({required this.refreshToken});
  @override
  List<Object> get props => [];
}
