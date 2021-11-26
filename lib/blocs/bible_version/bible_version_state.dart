part of 'bible_version_bloc.dart';

@immutable
class BibleVersionState extends Equatable {
  final BibleVersionStatus? status;
  final b.BibleVersionModel? model;
  final b.Data? savedVersion;
  final Failure? failure;
  BibleVersionState({this.status, this.model,this.savedVersion, this.failure});
  factory BibleVersionState.initial() {
    return BibleVersionState(
        status: BibleVersionStatus.initial, model: b.BibleVersionModel.empty(),savedVersion: b.Data.empty());
  }
  BibleVersionState copyWith(
      {BibleVersionStatus? status,
      b.BibleVersionModel? model,
      b.Data? savedVersion,
      Failure? failure}) {
    return BibleVersionState(
        model: model ?? this.model,
        status: status ?? this.status,
        savedVersion: savedVersion ?? this.savedVersion,
        failure: failure ?? this.failure);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, model,savedVersion, failure];
}

enum BibleVersionStatus { initial, loading, loaded, error }
