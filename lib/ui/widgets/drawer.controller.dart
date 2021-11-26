import 'package:flutter/material.dart';

class IbDrawerController with ChangeNotifier{
  int? selectedId;

  select(int? id){
    this.selectedId = id;
    notifyListeners();
  }
}