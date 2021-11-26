part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
  unverfiedemail,
  incompleteprofile,
  passwordreset,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    required this.user,
  });

  const AuthenticationState.unknown(AppUser user)
      : this._(
          user: user,
          status:AuthenticationStatus.unknown,
        );

  const AuthenticationState.authenticated(AppUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated(AppUser user)
      : this._(status: AuthenticationStatus.unauthenticated, user: user);

  const AuthenticationState.unverified(AppUser user)
      : this._(
          status: AuthenticationStatus.unverfiedemail,
          user: user,
        );
  const AuthenticationState.passwordReset(AppUser user):this._(user:user, status:AuthenticationStatus.passwordreset);
  const AuthenticationState.incompleteProfile(AppUser user)
      : this._(status: AuthenticationStatus.incompleteprofile, user: user);
  final AuthenticationStatus status;
  final AppUser user;

  @override
  List<Object> get props => [status, user];
}