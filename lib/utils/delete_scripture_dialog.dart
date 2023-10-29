import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

deleteScriptureDialog(BuildContext openContext, Passage scripture,
    VoidCallback deleteVerse) {
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
              deleteVerse();
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
