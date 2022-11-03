import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ible/blocs/repos/category_repo.dart';
import 'package:ible/models/category_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  StreamSubscription<List<Category>>? _stream;
  CategoryRepo _categoryRepo = CategoryRepo();
  FirebaseAuth _auth = FirebaseAuth.instance;
  CategoriesBloc() : super(CategoriesState.initial()) {
    on<CategoriesEventLoadCategories>((event, emit) {
      emit(state.copyWith(
          status: CategoriesStatus.loading, categories: state.categories));
      try {
        final userId = _auth.currentUser?.uid;
        _stream = _categoryRepo
            .getAllCategories(userId: userId ?? '')
            .listen((event) {
          add(CategoriesEventUpdateCategories(categories: event));
        });
      } catch (e) {
        emit(state.copyWith(
            status: CategoriesStatus.error, categories: state.categories));
      }
    });
    on<CategoriesEventUpdateCategories>((event, emit) {
      emit(state.copyWith(
          status: CategoriesStatus.loaded, 
          favoriteCategory: event.categories.where((element) => element.id == "2").isNotEmpty ? event.categories.where((element) => element.id == "2").toList()[0] :Category.favorite(),
          memoryVersesCategory: event.categories.where((element) => element.id == "1").isNotEmpty ? event.categories.where((element) => element.id == "1").toList()[0] :Category.memory(),
          categories: event.categories));
    });
    on<CategoriesEventSelectCategory>((event, emit) {
      emit(state.copyWith(status: CategoriesStatus.loading));
      emit(state.copyWith(
          status: CategoriesStatus.loaded, selectedCategory: event.category));
    });
    on<CategoriesEventAddCategory>((event, emit) async {
      try {
        await _categoryRepo.createCategory(
            category: event.category, userId: _auth.currentUser?.uid ?? '');
      } catch (e) {
        emit(state.copyWith(
            categories: state.categories, status: CategoriesStatus.error));
      }
    });
    on<CategoriesEventRenameCategory>((event, emit) async {
      try {
        await _categoryRepo.createCategory(
            category: event.category, userId: _auth.currentUser?.uid ?? '');
      } catch (e) {
        emit(state.copyWith(
            categories: state.categories, status: CategoriesStatus.error));
      }
    });
    on<CategoriesEventDeleteCategory>((event, emit) async {
      try {
        await _categoryRepo.deleteCategory(
            category: event.category, userId: _auth.currentUser?.uid ?? '');
      } catch (e) {
        emit(state.copyWith(
            categories: state.categories, status: CategoriesStatus.error));
      }
    });
  }
}
