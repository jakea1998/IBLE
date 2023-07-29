part of 'selected_item_bloc.dart';

enum SelectedItemType { 

  Note,
  Category; 

  String toJson() => name;
  static SelectedItemType fromJson(String json) => values.byName(json);
  }



class SelectedItemState extends Equatable {
  final dynamic selectedItem;
  final SelectedItemType? selectedItemType;
  final DefaultStatuses? status;
  const SelectedItemState(
      {this.selectedItem, this.selectedItemType, this.status});
  factory SelectedItemState.initial() {
    return SelectedItemState(
        status: DefaultStatuses.initial,
        selectedItem: null,
        selectedItemType: null);
  }
  SelectedItemState copyWith(
      {dynamic selectedItem,
      SelectedItemType? selectedItemType,
      DefaultStatuses? status}) {
    return SelectedItemState(
        selectedItem: selectedItem ?? this.selectedItem,
        selectedItemType: selectedItemType ?? this.selectedItemType,
        status: status ?? this.status);
  }
  Map<String,dynamic> toJson(){
    if(selectedItem == null || selectedItemType == null || status == null)
      return {};
    return {
      "selectedItem":selectedItemType == SelectedItemType.Note ?(selectedItem as NoteModel).toJson() : (selectedItem as Category).toJson() ,
      "selectedItemType":selectedItemType?.toJson(),
      "status":status?.toJson()
    };
    }
  factory SelectedItemState.fromJson(Map<String,dynamic> json){
    final selectedItemType=SelectedItemType.fromJson(json["selectedItemType"]);
    final selectedItem = selectedItemType == SelectedItemType.Note ? NoteModel.fromJson(json:json["selectedItem"]) : Category.fromJson(json["selectedItem"]);
    return SelectedItemState(
       selectedItem:selectedItem,
        selectedItemType:selectedItemType,
        status:DefaultStatuses.fromJson(json["status"])
    )
       ;}

  @override
  List<Object?> get props => [status, selectedItem, selectedItemType];
}
