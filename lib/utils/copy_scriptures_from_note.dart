import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

Future copyScripturesFromNote(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Note',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ThemeColors.grey9B9B9B,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Image.asset(
              'assets/images/icons/move_to.png',
              height: 24,
              color: ThemeColors.grey9B9B9B,
            ),
            Text(
              'Category',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ThemeColors.grey9B9B9B,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        message: Text(
          'Transfer note scriptures to category?',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: ThemeColors.grey9B9B9B,
              ),
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Yes',
              style: TextStyle(color: ThemeColors.blue027CFE),
            ),
            onPressed: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => CupertinoActivityIndicator());
              /* final scriptureController =
                  Provider.of<ScriptureController>(context, listen: false);
              final scriptures = await scriptureController
                  .generateScriptures(category!.description!);
              print('Found: $scriptures');
              await scriptureController.addAll(scriptures, category!);
              Provider.of<CategoryController>(context, listen: false).refresh(); */
              Navigator.pop(context);
              showNotificationDialog(context, 'Scriptures copied');
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'No',
              style: TextStyle(color: ThemeColors.blue027CFE),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }