part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}
