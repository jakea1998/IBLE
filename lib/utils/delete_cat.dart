import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

///Function deletes selected category from the database.
///
/// TODO: Implement proper notifications for actions taken.
/// TODO: Change background color for the cupertino  actionsheet item.
Future<bool> deleteCategoryDialog(
    BuildContext context, Category? category) async {
  final done = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: Container(
          child: Text(
            'Delete Category & Note?',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        message: Container(
          child: Text(
            'Deleting this category will delete it and it\'s note permanently.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(DeleteCategoryEvent(category));
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(GetCategories());
              /* final categoryController =
                  Provider.of<CategoryController>(context, listen: false); */
              /* await categoryController.delete(category!.id);
              categoryController.refresh(); */
              BlocProvider.of<CategoriesBloc>(context).add(
                  CategoriesEventDeleteCategory(
                      category: category ?? Category()));
              await showNotificationDialog(context, "Category Deleted");
              Navigator.pop(context, true);
            },
            child: Text('OK'),
            isDestructiveAction: true,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
        ),
      );
    },
  );
  return done ?? false;
}