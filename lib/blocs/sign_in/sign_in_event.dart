part of 'sign_in_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();
}

class EmailChanged extends SigninEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SigninEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class Submitted extends SigninEvent {
  const Submitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}




// class SigninTestPressed extends SigninEvent {
//   @override
//   List<Object> get props => [];
// }



class SigninButtonPressed extends SigninEvent {
  final String email;
  final String password;

  SigninButtonPressed({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
