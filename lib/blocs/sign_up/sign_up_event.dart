part of 'sign_up_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class EmailChanged extends SignupEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignupEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignupEvent {
  const ConfirmPasswordChanged(
      {required this.password, required this.confirmPassword});

  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}

class Submitted extends SignupEvent {
  const Submitted({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

