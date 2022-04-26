part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetMyAccount extends AccountEvent {
  // final int userId;
  // const GetMyAccount({required this.userId});
  @override
  List<Object> get props => [];
}

class UpdateMyAccount extends AccountEvent {
  var account;
  UpdateMyAccount({this.account});
  @override
  List<Object> get props => [account];
}

class GetMyLocalAccount extends AccountEvent {
  @override
  List<Object> get props => [];
}

class GetPlayer extends AccountEvent {
  final int userId;
  GetPlayer(this.userId);
  @override
  List<Object> get props => [];
}
