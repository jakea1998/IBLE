part of 'sign_in_bloc.dart';

class SigninState {
  const SigninState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.message,
  });

  bool get isSignInFormValid =>
      isEmailValid && isPasswordValid && !isSubmitting;

  factory SigninState.empty() {
    return SigninState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isEmailValid: false,
      isPasswordValid: false,
    );
  }

  factory SigninState.loading() {
    return SigninState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SigninState.failure(message) {
    return SigninState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        message: message);
  }

  factory SigninState.success() {
    return SigninState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String? message;

  SigninState copyWith({
    bool? isSubmitEnabled,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return SigninState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      message: message,
    );
  }

  @override
  String toString() {
    return '''SigninState {

      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      message: $message
    }''';
  }
}
