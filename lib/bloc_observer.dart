import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType} $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace? stackTrace) {
    print('${bloc.runtimeType} $error');
  }

  @override
  void onChange(BlocBase bloc, Object? event) {
    print('${bloc.runtimeType} $event');
  }

  @override
  void onTransitioned(BlocBase bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
  }
}
