import 'package:bloc/bloc.dart';

/// {@template counter_observer}
/// [BlocObserver] for the uno application which
/// observes all state changes.
/// {@endtemplate}
class UnoBlocObserver extends BlocObserver {

  const UnoBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }
}