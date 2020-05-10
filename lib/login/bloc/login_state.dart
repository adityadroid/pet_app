part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginProgress extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Authenticated extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationFailure extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
