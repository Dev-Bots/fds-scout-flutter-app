part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// ====================Login====================

class LoggingIn extends AuthState {}

class LoggedIn extends AuthState {
  final user;

  const LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailed extends AuthState {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthFailure { error: $error }';
}

// ====================Token Refresh====================

class RefreshingToken extends AuthState {}

class TokenRefreshed extends AuthState {
  final accessToken;
  const TokenRefreshed({required this.accessToken});
  @override
  List<Object> get props => [accessToken];
}

class TokenRefreshFailed extends AuthState {
  final String error;

  const TokenRefreshFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthFailure { error: $error }';
}

// ====================Check Authentication====================

class CheckingAuth extends AuthState {}

class IsAuthenticated extends AuthState {}

class IsNotAuthenticated extends AuthState {}

// ====================Logout====================

class LoggingOut extends AuthState {}

class LoggedOut extends AuthState {
  @override
  List<Object> get props => [];
}

class LogoutFailed extends AuthState {
  final String error;

  const LogoutFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthFailure { error: $error }';
}

// ====================Register====================

class Registering extends AuthState {}

class Registered extends AuthState {
  final account;

  const Registered({required this.account});

  @override
  List<Object> get props => [account];
}

class RegisterFailed extends AuthState {
  final String error;

  const RegisterFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}
