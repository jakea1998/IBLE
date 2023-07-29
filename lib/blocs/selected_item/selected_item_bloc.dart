import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/note_model.dart';

part 'selected_item_event.dart';
part 'selected_item_state.dart';

class SelectedItemBloc
    extends HydratedBloc<SelectedItemEvent, SelectedItemState> {
  

  SelectedItemBloc()
      : super(SelectedItemState.initial()) {
    on<SelectedItemEventSelectItem>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(status: DefaultStatuses.loading));
      if(event.item is Category)
        emit(state.copyWith(selectedItem: event.item, selectedItemType: SelectedItemType.Category,status: DefaultStatuses.loaded));
      else if(event.item is NoteModel)
        emit(state.copyWith(selectedItem: event.item, selectedItemType: SelectedItemType.Note, status: DefaultStatuses.loaded ));
    });
  }

  @override
  SelectedItemState? fromJson(Map<String, dynamic> json) {
   
    return SelectedItemState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SelectedItemState state) {
  
    return state.toJson();
  }
}
