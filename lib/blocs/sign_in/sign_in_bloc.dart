import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ible/blocs/repos/authentication_repository.dart';
import 'package:ible/blocs/utils/validator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState>
    with EmailAndPasswordValidators {
  SigninBloc({
    required AuthenticationRepository authenticationRepository,
    // required FirebaseEmailLinkHandler firebaseEmailLinkHandler,
  })  : _authenticationRepository = authenticationRepository,
        // _firebaseEmailLinkHandler = firebaseEmailLinkHandler,
        super(SigninState.empty()) {
    on<EmailChanged>((event, emit) {
      print(" the email is ${emailSignUpValidator.isValid(event.email)}");
    emit(state.copyWith(
      isEmailValid: emailSignUpValidator.isValid(event.email),
    ));
    });
    on<PasswordChanged>((event, emit) {
      print('The password is ${passwordValidValidator.isValid(event.password)}');
    emit(state.copyWith(
        isPasswordValid: passwordValidValidator.isValid(event.password)));
    });
    on<SigninButtonPressed>((event, emit) async {
     try {
      emit( SigninState.loading());
      await _authenticationRepository.signInWithEmailAddressAndPassword(
          event.email, event.password);
      // _firebaseEmailLinkHandler.sendSignInWithEmailLink(
      //   email: email,
      //   url: projectURL,
      //   handleCodeInApp: true,
      //   packageName: packageInfo.packageName,
      //   androidInstallApp: true,
      //   androidMinimumVersion: '21',
      // );
      emit(SigninState.success());
    } on PlatformException catch (e) {
      emit(SigninState.failure(e.message));
    }
    });
  }
  final AuthenticationRepository _authenticationRepository;
  // final FirebaseEmailLinkHandler _firebaseEmailLinkHandler;

  
}
