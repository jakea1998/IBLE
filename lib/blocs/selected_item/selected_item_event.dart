part of 'selected_item_bloc.dart';

abstract class SelectedItemEvent extends Equatable {
  const SelectedItemEvent();

  @override
  List<Object> get props => [];
}

class SelectedItemEventSelectItem extends SelectedItemEvent{
  final dynamic item;
  final SelectedItemType itemType;
  SelectedItemEventSelectItem({required this.item,required this.itemType});
  @override
  List<Object> get props => [item,itemType];
}