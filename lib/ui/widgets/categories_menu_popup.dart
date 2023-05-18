import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';
import 'package:ible/utils/delete_cat.dart';
import 'package:ible/utils/rename_cat.dart';

class CategoriesMenuPopup extends StatelessWidget {
  final Category category;
  const CategoriesMenuPopup({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0.0),
      child: DCupertinoOverflowMenu(
        children: [
          if (category.id != "1" && category.id != "2")
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                renameCategory(context, category);
              },
              child: Text('Edit Name'),
            ),
          if (category.id != "1" && category.id != "2")
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);

                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Category',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                          'Note',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: ThemeColors.grey9B9B9B,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    message: Text(
                      'Transfer category scriptures to note?',
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
                        onPressed: () {
                          /*  Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  SlideFromRightPageRoute(
                                    widget: CategoryNotePage(
                                        category: category,
                                        scriptures: controller.notes),
                                  ),
                                ).then((value) {
                                  if (value) _copyScripturesFromNote();
                                }); */
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text(
                          'No',
                          style: TextStyle(color: ThemeColors.blue027CFE),
                        ),
                        onPressed: () {
                          /*  /* Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  SlideFromRightPageRoute(
                                    widget: CategoryNotePage(
                                      category: category,
                                      scriptures: [],
                                    ),
                                  ), */
                                ).then((value) {
                                  if (value) _copyScripturesFromNote();
                                }); */
                        },
                      )
                    ],
                  ),
                );
              },
              child: Text('Add Note'),
            ),
          if (category.id != 1 && category.id != 2 && category.parent == null)
            CupertinoActionSheetAction(
                onPressed: () {
                  /*   Navigator.pop(context);
                        Navigator.push(
                          context,
                          SlideFromRightPageRoute(
                              widget: AddScriptureToSubCategoryPage(
                            parent: this.widget.category!,
                          )),
                        ); */
                },
                child: Text('Add Sub category')),
          CupertinoActionSheetAction(
            onPressed: () {
              /*  Navigator.pop(context);
                    final scriptures = Provider.of<CategoryController>(
                      context,
                      listen: false,
                    ).notes!;
                    var list = '';
                    scriptures.forEach((scripture) {
                      list += '\n\n${scripture.print}';
                    });
                    Clipboard.setData(ClipboardData(text: list.trim())); */
            },
            child: Text('Copy Scripture List'),
          ),
          if (category.id != "1" && category.id != "2")
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await deleteCategoryDialog(
                    context,
                    BlocProvider.of<CategoriesBloc>(context)
                        .state
                        .selectedCategory);
              },
              child: Text('Delete Category'),
              isDestructiveAction: true,
            ),
        ],
        borderRadius: BorderRadius.circular(13),
        iconColor: Colors.white,
        onChange: (index) {
          print(index);
        },
      ),
    );
    /*  Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => SharePage(
              //       category: category,
              //     ),
              //   ),
              // );
            },
            child: ImageIcon(
              AssetImage('assets/images/icons/share.png'),
              size: 26.0,
              color: ThemeColors.appBarIconColor,
            ),
          ),
        ) */
  }
}
