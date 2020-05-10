import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_app/config/constants.dart';
import 'package:pet_app/models/login_response.dart';
import 'package:pet_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authService;
  final SharedPreferences sharedPreferences;

  LoginBloc(this.authService, this.sharedPreferences);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield LoginProgress();
      try {
        final LoginResponse response =
            await authService.signIn(event.email, event.password);
        if (response == null) {
          yield AuthenticationFailure();
          return;
        }
        sharedPreferences.setString(ACCESS_TOKEN, response.access);
        yield Authenticated();
      } catch (e, stacktrace) {
        print(stacktrace);
        yield AuthenticationFailure();
      }
    }
  }
}
