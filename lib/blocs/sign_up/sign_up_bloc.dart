import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/blocs/repos/authentication_repository.dart';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:ible/blocs/utils/validator.dart';


import 'package:rxdart/rxdart.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>
    with EmailAndPasswordValidators {
  SignupBloc({required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(SignupState.empty());
  final AuthenticationRepository _authenticationRepository;

  String? _email;

  @override
  Stream<Transition<SignupEvent, SignupState>> transformEvents(
    Stream<SignupEvent> events,
    TransitionFunction<SignupEvent, SignupState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! ConfirmPasswordChanged;
    });
    final debounceStream = events.where((event) {
      return event is EmailChanged ||
          event is PasswordChanged ||
          event is ConfirmPasswordChanged;
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.password, event.confirmPassword);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.email,
        event.password,
      );
    }
  }

  Stream<SignupState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: emailSignUpValidator.isValid(email),
    );
  }

  Stream<SignupState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: passwordValidValidator.isValid(password),
    );
  }

  Stream<SignupState> _mapConfirmPasswordChangedToState(
      String password, String confirmPassword) async* {
    final isValid = password == confirmPassword;

    print(
        'the value of password is ${password} and confirmPassword is ${confirmPassword} and is valid ${isValid}');
    yield state.update(isConfirmPasswordValid: isValid);
  }

  Stream<SignupState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield SignupState.loading();
    try {
      _email = email;
      await _authenticationRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      yield SignupState.success();
    } on PlatformException catch (e) {
      yield SignupState.failure(e.message ?? "Error");
    }
  }
}

