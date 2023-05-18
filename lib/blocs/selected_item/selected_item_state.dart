part of 'selected_item_bloc.dart';
enum SelectedItemType{Category,Note}
enum SelectedItemStatus { loading, loaded, error, initial }
class SelectedItemState extends Equatable {
  final dynamic selectedItem;
  final SelectedItemType? selectedItemType;
  final SelectedItemStatus? status;
  const SelectedItemState({this.selectedItem,this.selectedItemType, this.status});

  @override
  List<Object> get props => [];
}

class SelectedItemInitial extends SelectedItemState {}
