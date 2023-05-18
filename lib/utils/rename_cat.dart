import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/utils/edit_cat.dart';

void renameCategory(openContext, Category? category) => showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: openContext,
      pageBuilder: (context, anim1, anim2) {
        final _textFieldController = TextEditingController();
        _textFieldController.value = _textFieldController.value.copyWith(
          text: category!.title,
          selection: TextSelection(
              baseOffset: 0, extentOffset: category.title!.length),
          composing: TextRange.empty,
        );
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'RENAME CATEGORY',
                        style: Theme.of(context).textTheme.caption!.copyWith(),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: ImageIcon(
                          AssetImage(
                              'assets/images/icons/Combined Shape Copy 2.png'),
                          color: ThemeColors.greyAAA7AA,
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: ThemeColors.pinkFFB1AC,
                        selectionColor: ThemeColors.pinkFFB1AC,
                        selectionHandleColor: ThemeColors.pinkFFB1AC,
                      ),
                    ),
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        primaryColor: ThemeColors.pinkFFB1AC,
                      ),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          // suffixIcon: IconButton(
                          //   onPressed: () => _textFieldController.clear(),
                          //   icon: ImageIcon(
                          //       AssetImage('assets/images/icons/close.png')),
                          // ),
                        ),
                        cursorColor: ThemeColors.pinkFFB1AC,
                        cursorWidth: 1,
                        style: TextStyle(
                          fontSize: 17,
                          color: ThemeColors.grey2E3235,
                        ),
                        controller: _textFieldController,
                        onSubmitted: (value) {
                          category.title = value.trim();
                          editCategory(openContext, category);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              margin:
                  EdgeInsets.only(top: 344, bottom: 50, left: 12, right: 12),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );