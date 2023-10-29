import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ible/blocs/repos/category_repo.dart';
import 'package:ible/blocs/selected_item/selected_item_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final SelectedItemBloc selectedItemBloc;
  StreamSubscription<List<Category>>? _stream;
  CategoryRepo _categoryRepo = CategoryRepo();
  FirebaseAuth _auth = FirebaseAuth.instance;
  CategoriesBloc({required this.selectedItemBloc})
      : super(CategoriesState.initial()) {
    selectedItemBloc.stream.listen((event) {
      if (event.selectedItem is Category) {
        add(CategoriesEventSelectCategory(category: event.selectedItem));
      }
    });
    on<CategoriesEventLoadCategories>((event, emit) async {
      emit(state.copyWith(
          status: CategoriesStatus.loading, categories: state.categories));
      try {
        final userId = _auth.currentUser?.uid;

        _stream = _categoryRepo
            .getAllCategories(userId: userId ?? '')
            .listen((event) {
          print("update");
          add(CategoriesEventUpdateCategories(categories: event));
        });
      } catch (e) {
        emit(state.copyWith(
            status: CategoriesStatus.error, categories: state.categories));
      }
    });
    on<CategoriesEventUpdateCategories>((event, emit) {
      print("update");
      List<Category> categoriesAndSubCategories = [];
      List<String> categoriesAndSubCategoriesTitles = [];
      List<String> subCategoriesTitles = [];
      event.categories.forEach((element) {
        categoriesAndSubCategories.add(element);
        categoriesAndSubCategoriesTitles.add(element.title ?? "");
        if (element.subCategories?.isNotEmpty ?? false)
          element.subCategories?.forEach((sub) {
            categoriesAndSubCategories.add(sub);
            subCategoriesTitles.add(sub.title ?? "");
          });
      });
      final selectedCategory = categoriesAndSubCategories.firstWhere((element) {
        return element.id.toString() == state.selectedCategory?.id.toString();
      });
      
      emit(state.copyWith(
          status: CategoriesStatus.loaded,
          subCategoriesTitles: subCategoriesTitles,
          categoriesAndSubCategories: categoriesAndSubCategories,
          
          categoriesAndSubCategoriesTitles: categoriesAndSubCategoriesTitles,
          selectedCategory: selectedCategory,
          favoriteCategory:
              event.categories.where((element) => element.id == "2").isNotEmpty
                  ? event.categories
                      .where((element) => element.id == "2")
                      .toList()[0]
                  : Category.favorite(),
          memoryVersesCategory:
              event.categories.where((element) => element.id == "1").isNotEmpty
                  ? event.categories
                      .where((element) => element.id == "1")
                      .toList()[0]
                  : Category.memory(),
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
        if(event.category.id == state.selectedCategory?.id){
          selectedItemBloc.add(SelectedItemEventSelectItem(item: state.favoriteCategory));
        }
        await _categoryRepo.deleteCategory(
            category: event.category, userId: _auth.currentUser?.uid ?? '');
      } catch (e) {
        emit(state.copyWith(
            categories: state.categories, status: CategoriesStatus.error));
      }
    });
    on<CategoriesEventPinOrUnpinVerse>((event, emit) async {
      if (state.selectedCategory != null) {
        emit(state.copyWith(status: CategoriesStatus.loading));

        if (event.pinOrUnpin) {
          state.selectedCategory?.pinned = event.verse;
        } else {
          state.selectedCategory?.pinned = null;
        }

        emit(state.copyWith(
            status: CategoriesStatus.loaded,
            selectedCategory: state.selectedCategory));
        await _categoryRepo.createCategory(
            category: state.selectedCategory ?? Category(),
            userId: _auth.currentUser?.uid ?? '');
      }
    });
  }
}
