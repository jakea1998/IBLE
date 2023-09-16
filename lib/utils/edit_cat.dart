import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

editCategory(BuildContext context, Category? category) async {
 
  /* final edited = await Provider.of<CategoryController>(context, listen: false)
      .update(category); */
  /*  if (edited != null) {
    Navigator.of(context).pop();
    // BlocProvider.of<CategoryBloc>(context, listen: false).add(
    //   GetCategories(),
    // ); todo: Make sure that the CategoriesController works

    Provider.of<CategoryController>(context, listen: false).refresh();

    await showNotificationDialog(context, "Name Changed");
    // await showDialog(
    //   context: context,
    //   builder: (context) {
    //     return DNotificationDialog(
    //       content: 'Name Changed',
    //     );
    //   },
    // );
    return edited;
  } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Failed to edit')));
  } */
}
