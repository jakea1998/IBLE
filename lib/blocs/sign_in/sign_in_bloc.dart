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
        super(SigninState.empty());
  final AuthenticationRepository _authenticationRepository;
  // final FirebaseEmailLinkHandler _firebaseEmailLinkHandler;

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    

    // else if (event is SigninTestPressed) {
    //   _authenticationRepository.testLogin();
    // }
if (event is EmailChanged) {
      yield* _emailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _passwordChangedToState(event.password);
    } else if (event is SigninButtonPressed) {
      yield* _emailPasswordSignInPressed(event.email, event.password);
    }
  }

  Stream<SigninState> _emailChangedToState(String email) async* {
    print(" the email is ${emailSignUpValidator.isValid(email)}");
    yield state.copyWith(
      isEmailValid: emailSignUpValidator.isValid(email),
    );
  }

  Stream<SigninState> _passwordChangedToState(String password) async* {
    print('The password is ${passwordValidValidator.isValid(password)}');
    yield state.copyWith(
        isPasswordValid: passwordValidValidator.isValid(password));
  }

  Stream<SigninState> _emailPasswordSignInPressed(
      String email, String password) async* {
    try {
     
      yield SigninState.loading();
      await _authenticationRepository.signInWithEmailAddressAndPassword(
          email, password);
      // _firebaseEmailLinkHandler.sendSignInWithEmailLink(
      //   email: email,
      //   url: projectURL,
      //   handleCodeInApp: true,
      //   packageName: packageInfo.packageName,
      //   androidInstallApp: true,
      //   androidMinimumVersion: '21',
      // );
      yield SigninState.success();
    } on PlatformException catch (e) {
      yield SigninState.failure(e.message);
    }
  }


  

}

