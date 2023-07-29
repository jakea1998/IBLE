part of 'selected_item_bloc.dart';

abstract class SelectedItemEvent extends Equatable {
  const SelectedItemEvent();

  @override
  List<Object> get props => [];
}

class SelectedItemEventSelectItem extends SelectedItemEvent{
  final dynamic item;
  
  SelectedItemEventSelectItem({required this.item});
  @override
  List<Object> get props => [item];
}