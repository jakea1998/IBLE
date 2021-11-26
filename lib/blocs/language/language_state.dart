part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final List<String>? languagesList;
  final LanguageStatus? languageStatus;
  final Failure? failure;
  const LanguageState({this.languagesList, this.languageStatus, this.failure});
  factory LanguageState.initial() {
    return LanguageState(
        languageStatus: LanguageStatus.initial,
        languagesList: [],
        failure: Failure(message: ''));
  }
  LanguageState copyWith(
      {List<String>? languagesList,
      LanguageStatus? languageStatus,
      Failure? failure}) {
    return LanguageState(
        languagesList: languagesList ?? this.languagesList,
        languageStatus: languageStatus ?? this.languageStatus,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [languagesList, languageStatus, failure];
}

enum LanguageStatus { initial, loading, loaded, error }
