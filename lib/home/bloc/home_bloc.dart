import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.sharedPreferences);

  @override
  HomeState get initialState => HomeInitial();

  final SharedPreferences sharedPreferences;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is SignOut) {
      sharedPreferences.clear();
      yield SignedOut();
    }
  }
}
