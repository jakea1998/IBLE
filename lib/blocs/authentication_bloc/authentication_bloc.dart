import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/blocs/repos/authentication_repository.dart';
import 'package:ible/models/user.model.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          AuthenticationState.unknown(AppUser.empty()),
        );

  //TODO temporary
  final testUser = AppUser.empty();

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      await _authenticationRepository.signOut();
    } else if (event is AuthenticationDeleteRequested) {
      await _authenticationRepository.deleteUserFromFirebaseAuth(
          user: state.user);
      await _authenticationRepository.deleteUserFromFirestore(user: state.user);
    } else if (event is AuthenticationPasswordResetRequested) {
      //TODO: implement this section
      await _authenticationRepository.sendPasswordResetEmail(state.user.email ?? '');
    }
  }

  @override
  Future<void> close() {
    // _authenticationRepository.dispose();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    if (event.user.id == testUser.id) {
      print('unauthenticated');
      return AuthenticationState.unauthenticated(testUser);
    } else if (event.user.email != testUser.email) {
      print('authenticated');
      return AuthenticationState.authenticated(event.user);
    } else {
      print('unknown');
      return AuthenticationState.unknown(testUser);
    }
  }
}
