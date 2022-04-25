import 'package:bloc/bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository = AccountRepository();

  final prefs = SharedPreferences.getInstance();

  AccountBloc() : super(AccountLoading()) {
    on<GetMyAccount>((event, emit) async {
      emit(AccountLoading());
      var user = await accountRepository.getCurrentUser();

      if (user != null) {
        emit(AccountLoaded(user: user));
      } else {
        emit(const AccountFailed(error: "Failed to load."));
      }
    });
    on<GetMyLocalAccount>((event, emit) async {
      emit(AccountLocalLoading());
      var user = await accountRepository.getLocalAccount();
      if (user != null) {
        print('Account on Bloc: $user');

        emit(AccountLocalLoaded(user: user));
      } else {
        emit(const AccountLocalFailed(error: "Failed to load."));
      }
    });
    on<UpdateMyAccount>((event, emit) async {
      emit(AccountUpdating());
      var user = await accountRepository.updateAccount(event.account);
      if (user != null) {
        emit(AccountUpdated(user: user));
      } else {
        emit(const AccountUpdateFailed(error: "Failed to load."));
      }
    });

    on<GetPlayer>((event, emit) async {
      emit(AccountLoading());
      var user = await accountRepository.getPlayer(event.userId);

      if (user != null) {
        emit(AccountLoaded(user: user));
      } else {
        emit(const AccountFailed(error: "Failed to load."));
      }
    });
  }
}
