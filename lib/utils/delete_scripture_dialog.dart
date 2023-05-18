import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

deleteScriptureDialog(BuildContext openContext, Passage scripture) {
  showCupertinoModalPopup(
    context: openContext,
    builder: (context) {
      return CupertinoActionSheet(
        title: Container(
          child: Text(
            'Delete Scripture?',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        message: Container(
          child: Text(
            'Deleting this scripture will remove it permanently.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              if (BlocProvider.of<CategoriesBloc>(context)
                      .state
                      .selectedCategory
                      ?.pinned !=
                  null) if (BlocProvider.of<CategoriesBloc>(context)
                      .state
                      .selectedCategory
                      ?.pinned
                      ?.id
                      .toString() ==
                  scripture.id.toString()) {
                BlocProvider.of<CategoriesBloc>(context)
                    .add(CategoriesEventPinOrUnpinVerse(pinOrUnpin: false));
              }
              print('delete');
              BlocProvider.of<ScripturesBloc>(context).add(
                  ScripturesEventDeleteVerse(
                      category: BlocProvider.of<CategoriesBloc>(context)
                              .state
                              .selectedCategory ??
                          Category(),
                      verse: scripture));

              /*  await Provider.of<ScriptureController>(context, listen: false)
                  .delete(scripture.id);
              await Provider.of<CategoryController>(context, listen: false)
                  .refresh(); */
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(GetCategories());
              Navigator.pop(context);
              showNotificationDialog(openContext, "Scripture Deleted");
            },
            child: Text('OK'),
            isDestructiveAction: true,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      );
    },
  );
}
