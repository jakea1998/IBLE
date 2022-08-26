part of 'bible_version_bloc.dart';

@immutable
abstract class BibleVersionEvent extends Equatable {}

class BibleVersionEventFetchAllBibleVersions extends BibleVersionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BibleVersionEventSaveBibleVersion extends BibleVersionEvent {
  final b.Data? data;
  BibleVersionEventSaveBibleVersion({this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class BibleVersionFetchSavedBibleVersion extends BibleVersionEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class BibleVersionUpdateBibleVersion extends BibleVersionEvent {
  final b.Data? data;
  BibleVersionUpdateBibleVersion({this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}