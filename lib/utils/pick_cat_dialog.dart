import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

showPickCategoryDialog(
    {required BuildContext context,
    required Function() memoryVerseTapped,
    required List<Category> categories,
    required Function() newCatTapped,
    required bool showNewCat,
    required VoidCallback favoriteVerseTapped,
    required Function(Category) catTapped}) {
  //List<Category> categories1 = [];
  List<Widget> getListOfCategories(BuildContext context) {
    List<Widget> widgets = [];
    categories.forEach((element) {
      widgets.add(Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              catTapped(element);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (element.parent != "null" &&
                  element.parent != null)
                Padding(
                  padding: EdgeInsets.only(right: 4, bottom: 12),
                  child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5))),
                ),
                Container(
                  color: /* (widget.category?.id ==
                                                categories?[index].id)
                                            ? ThemeColors.greyECECEC
                                            : */
                      Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          element.title ?? "",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                               color: ThemeColors.grey595959,
                                fontSize: 20,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            
            thickness: 1,
          )
        ],
      ));
    });
    return widgets;
  }

  showPersistentDialogFromBottom(
    context,
    child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 44),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:15.0,right: 15,left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        'CHOOSE CATEGORY',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: ThemeColors.grey595959,
                              fontSize: 20,
                            ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        child: ImageIcon(
                            AssetImage('assets/images/icons/close.png')),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                showNewCat
                    ? Padding(padding: EdgeInsets.only(top: 15))
                    : Container(),
                showNewCat
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);

                                newCatTapped();
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'New category',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                         color: ThemeColors.grey595959,
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Divider(
                  height: 0,
                 
                  thickness: 1,
                ),
                Container(
                  color: /* (widget.category?.id == 1)
                        ? ThemeColors.greyECECEC
                        : */
                      Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            memoryVerseTapped();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Memory Verses',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: ThemeColors.grey595959,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                 
                  thickness: 1,
                ),
                Container(
                  color: /* (widget.category?.id == 2)
                        ? ThemeColors.greyECECEC
                        :  */
                      Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          favoriteVerseTapped();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Favorites',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: ThemeColors.grey595959,
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  
                  thickness: 2,
                ),
                Expanded(
                    child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  children: getListOfCategories(context),
                  shrinkWrap: true,
                )),
              ],
            ),
          ),
        )),
  );
}
