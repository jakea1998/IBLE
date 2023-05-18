import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';

part 'selected_item_event.dart';
part 'selected_item_state.dart';

class SelectedItemBloc extends HydratedBloc<SelectedItemEvent, SelectedItemState> {
  final CategoriesBloc categoriesBloc;
  
  SelectedItemBloc({required this.categoriesBloc}) : super(SelectedItemInitial()) {
    on<SelectedItemEventSelectItem>((event, emit) {
      // TODO: implement event handler
      
    });
  }
  
  @override
  SelectedItemState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
  
  @override
  Map<String, dynamic>? toJson(SelectedItemState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
