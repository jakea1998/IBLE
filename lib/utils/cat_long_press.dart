import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/notes/notes_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/note_model.dart';
import 'package:ible/theme.dart';

import 'package:ible/ui/pages/add_scripture_page_new.dart';
import 'package:ible/ui/pages/category_page.dart';

import 'package:ible/ui/widgets/menu.dart';
import 'package:ible/utils/delete_cat.dart' as deleteCat;
import 'package:ible/utils/rename_cat.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Future _showDialogFromNowhere(context, {required Widget child}) async {
  return await showGeneralDialog(
    barrierLabel: 'Manage category',
    barrierDismissible: true,
    barrierColor: Color(0xFF474747).withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 150),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: ScaleTransition(
          alignment: Alignment.centerLeft,
          scale: CurvedAnimation(parent: anim1, curve: Curves.bounceInOut),
          child: child,
        ),
      );
    },
  );
}

onCategoryLongPress(BuildContext context, Category category, bool showSub) {
  HapticFeedback.mediumImpact();
  print(category.parent);
  _showDialogFromNowhere(context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 68),
            decoration: BoxDecoration(
              color: ThemeColors.grey414747,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${category.title}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(builder: (context, size) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      '${category.title}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 96.0,
              bottom: 0,
            ),
            decoration: BoxDecoration(
                color: ThemeColors.actionBackgroundColor,
                borderRadius: BorderRadius.circular(13)),
            child: Column(
              // title: Text(category.title),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 24.0),
                  child: Text(
                    '${category.title}',
                    style: TextStyle(
                      color: ThemeColors.grey9B9B9B,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(
                  color: ThemeColors.grey9B9B9B,
                  height: 0,
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    renameCategory(context, category);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 24),
                    child: Row(
                      children: [
                        Text(
                          (category.parent == null || category.parent.toString() == "null")? 'Rename Cat...' : 'Rename Subcat...',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        ImageIcon(
                          AssetImage(
                            'assets/images/icons/noun_iPad Pro 10 with Apple pencil_1377606.png',
                          ),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: ThemeColors.grey9B9B9B,
                  height: 0,
                ),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddScripturePageNew(
                            isSubCategory: false,
                            category: category,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 24),
                      child: Row(
                        children: [
                          Text('Add Verse'),
                          Spacer(),
                          Image.asset(
                            'assets/images/icons/fi_plus-circle.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    )),
                Divider(
                  color: ThemeColors.grey9B9B9B,
                  height: 0,
                ),
                if ((category.notes?.length ?? 0) == 0)
                  CupertinoActionSheetAction(
                      onPressed: () {
                        final newNote = NoteModel(
                            id: Uuid().v1(),
                            parentId: category.parent == "null"
                                ? category.id
                                : category.parent,
                            subParentId:
                                category.parent != "null" ? category.id : null,
                            createdAt: DateTime.now(),
                            title: "Note");

                        BlocProvider.of<NotesBloc>(context)
                            .add(NotesEventSaveNote(note: newNote));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 24),
                        child: Row(
                          children: [
                            Text('Add Note'),
                            Spacer(),
                            ImageIcon(
                              AssetImage('assets/images/icons/fi_file.png'),
                              color: Colors.black,
                            )
                          ],
                        ),
                      )),
                if (showSub)
                  Divider(
                    color: ThemeColors.grey9B9B9B,
                    height: 0,
                  ),
                if (showSub)
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddScripturePageNew(
                                      isSubCategory: true,
                                      parentCategory: category,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 24),
                        child: Row(
                          children: [
                            Text('Add Subcat...'),
                            Spacer(),
                            ImageIcon(
                              AssetImage('assets/images/icons/subcategory.png'),
                              color: Colors.black,
                            )
                          ],
                        ),
                      )),
                Divider(
                  color: ThemeColors.grey9B9B9B,
                  height: 0,
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.pop(context);
                    if (await (deleteCat.deleteCategoryDialog(context, category))) {
                      Provider.of<IbDrawerController>(context, listen: false)
                          .select("2");
                      BlocProvider.of<CategoriesBloc>(context).add(
                          CategoriesEventDeleteCategory(category: category));
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                              category: BlocProvider.of<CategoriesBloc>(context)
                                  .state
                                  .favoriteCategory),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 24),
                    child: Row(
                      children: [
                        Text('Delete Cat...'),
                        Spacer(),
                        Image.asset(
                          'assets/images/icons/fi_trash-2.png',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  isDestructiveAction: true,
                ),
              ],
            ),
          ),
        ],
      ));

  return;
}
