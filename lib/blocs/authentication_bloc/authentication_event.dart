part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final AppUser user;

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationDeleteRequested extends AuthenticationEvent {}

class AuthenticationPasswordResetRequested extends AuthenticationEvent{
  final String code;

  AuthenticationPasswordResetRequested(this.code);

  @override
  List<Object> get props => [code];
}