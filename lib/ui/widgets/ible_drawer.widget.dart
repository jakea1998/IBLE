import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/ui/pages/category.page.dart';

import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';
import 'package:ible/ui/widgets/drawer.controller.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/utils/text_has_overflow.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'drawer_list_item.widget.dart';

class IbleFlatDrawer extends StatefulWidget {
  @override
  _IbleFlatDrawerState createState() => _IbleFlatDrawerState();
}

class _IbleFlatDrawerState extends State<IbleFlatDrawer> {
  int? expandedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
        /* Consumer2<IbDrawerController,>(
          builder: (context, drawerController, categoryController, _) {
        return Container(
          decoration: BoxDecoration(color: ThemeColors.grey2E3235),
          child: SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Column(
              children: [
                buildDrawerHeader(context),
                DrawerListItem(
                  selected: drawerController.selectedId == 1,
                  title: 'Memory Verse',
                  onTap: () {
                    Provider.of<IbDrawerController>(context, listen: false)
                        .select(1);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          category: Category(
                            id: 1,
                            title: 'Memory Verse',
                          ),
                        ),
                      ),
                    );
                  },
                  iconWidget: Image.asset(
                    'assets/images/icons/memory_verses.png',
                    width: 24,
                  ),
                ),
                DrawerListItem(
                  selected: drawerController.selectedId == 2,
                  title: 'Favorite',
                  onTap: () {
                    Provider.of<IbDrawerController>(context, listen: false)
                        .select(2);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          category: Category(
                            id: 2,
                            title: 'Favorite',
                          ),
                        ),
                      ),
                    );
                  },
                  iconWidget: Image.asset(
                    'assets/images/icons/favorites.png',
                    width: 24,
                  ),
                ),
                // DrawerListItem(
                //   selected: drawerController.selectedId == -3,
                //   title: 'Settings',
                //   onTap: () {
                //     Provider.of<IbDrawerController>(context,
                //         listen: false)
                //         .select(-3);
                //     Navigator.push(
                //       context,
                //       SlideFromRightPageRoute(widget: SettingsPage()),
                //     );
                //   },
                //   iconWidget: ImageIcon(
                //     AssetImage('assets/images/icons/settings.png'),
                //     color: ThemeColors.grey808082,
                //   ),
                // ),
                Expanded(
                  child: RawScrollbar(
                    thumbColor: ThemeColors.greyABABAB,
                    radius: Radius.circular(8),
                    thickness: 4,
                    child: ListView(
                      // padding: EdgeInsets.zero,
                      children: [
                        // Consumer<ShareController>(
                        //     builder: (context, shareController, child) {
                        //   return DrawerListItem(
                        //     selected: controller.selectedId == -4,
                        //     count: shareController.messages?.length ?? 0,
                        //     title: 'Inbox',
                        //     onTap: () {
                        //       Provider.of<IbDrawerController>(context,
                        //               listen: false)
                        //           .select(-4);
                        //       Navigator.push(context,
                        //           SlideFromRightPageRoute(widget: InboxPage()));
                        //     },
                        //     iconWidget: ImageIcon(AssetImage('assets/images/icons/inbox.png')),
                        //   );
                        // }),
                        Padding(padding: EdgeInsets.only(top: 12)),
                        if (categoryController.initialised)
                          for (int i = 0;
                              i < categoryController.categories!.length;
                              i++)
                            buildListTitle(
                                categoryController, i, drawerController),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 42.0),
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        SlideFromBottomPageRoute(
                          widget: /* AddScripturePage() */Container(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      side: BorderSide(width: 2, color: Color(0xFFCACADA)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 13),
                      child: Text(
                        'Add Verse',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                              letterSpacing: 0,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }), */
        );
  }

  /*  Builder buildListTitle(CategoryController categoryController, int i,
      IbDrawerController drawerController) {
    return Builder(
      builder: (context) {
        final category = categoryController.categories![i];
        final hasChildren = 0 < category.children!.length;
        final hasNote = category.description?.isNotEmpty ?? false;
        final showTrailing = hasChildren || hasNote;
        final bool isOpen = expandedCategory == category.id;
        return Column(
          children: [
            DrawerListItem(
              trailingIconWidget: showTrailing
                  ? InkWell(
                      child: Transform.rotate(
                        angle: isOpen ? math.pi / 2 : 0,
                        child: ImageIcon(
                          AssetImage('assets/images/icons/arrow_right.png'),
                        ),
                      ),
                      onTap: () => _toggleExpanded(category),
                    )
                  : null,
              count: category.children!.length,
              selected: drawerController.selectedId == category.id,
              title: '${category.title}',
              onTap: () {
                Provider.of<IbDrawerController>(context, listen: false)
                    .select(category.id);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: category,
                    ),
                  ),
                );
              },
              onLongPress: () => _onCategoryLongPress(context, category, true),
            ),
            if (isOpen)
              InkWell(
                onTap: () async {
                  //TODO: CLOSE THE DRAWER HERE.
                  Navigator.push(
                    context,
                    SlideFromRightPageRoute(
                        widget: Container()/* CategoryNotePage(
                      category: category,
                    ) */),
                  );
                },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 46)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: ImageIcon(
                        AssetImage('assets/images/icons/note.png'),
                        color: ThemeColors.grey808082,
                      ),
                    ),
                    Text(
                      'Note',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: ThemeColors.greyBCBCCO,
                          ),
                    ),
                  ],
                ),
              ),
            if (isOpen && hasChildren)
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListView.builder(
                    itemCount: category.children!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      final subCategory = category.children![position];
                      return Column(
                        children: [
                          DrawerListItem(
                            selected:
                                drawerController.selectedId == subCategory.id,
                            title: '${subCategory.title}',
                            onTap: () {
                              Provider.of<IbDrawerController>(context,
                                      listen: false)
                                  .select(subCategory.id);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                    category: subCategory,
                                  ),
                                ),
                              );
                            },
                            //todo: Work on this logic
                            onLongPress: () => _onCategoryLongPress(
                                context, subCategory, false),
                          ),
                          if (subCategory.description?.isNotEmpty ?? false)
                            InkWell(
                              onTap: () async {
                                //TODO: CLOSE THE DRAWER HERE.
                                Navigator.push(
                                  context,
                                  SlideFromRightPageRoute(
                                      widget:Container() /* CategoryNotePage(
                                    category: subCategory,
                                  ) */),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 46)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: ImageIcon(
                                      AssetImage(
                                          'assets/images/icons/note.png'),
                                      color: ThemeColors.grey808082,
                                    ),
                                  ),
                                  Text(
                                    'Note',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: ThemeColors.greyBCBCCO,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
              ),
          ],
        );
      },
    );
  }

  Container buildDrawerHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              child: Text(
                'IBLE',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Color(0xFF595D61),
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DCenteredOverflowMenu(
                backgroundColor: Colors.white,
                children: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/icons/mail.png',
                              height: 24,
                              width: 24,
                              color: ThemeColors.grey808082,
                            ),
                            Positioned(
                              right: -12,
                              top: -8,
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: ThemeColors.redFE3D2F,
                                  ),
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: ThemeColors.greyF7F7F7,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Inbox',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/search (1).png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Library',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          SlideFromRightPageRoute(widget:Container() /* SettingsPage() */));
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/settings (1).png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Settings',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          SlideFromRightPageRoute(widget: Container()/* LoginPage() */));
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/logout.png',
                          height: 24,
                          width: 24,
                          color: ThemeColors.grey808082,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Sign In',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // IconButton(
            //     padding: EdgeInsets.symmetric(horizontal: 12),
            //     constraints: BoxConstraints(),
            //     icon: Image.asset(
            //       'assets/images/icons/more.png',
            //       height: 24,
            //       width: 24,
            //     ),
            //     onPressed: () {}),
          ),
          Positioned(
            right: 20,
            top: -12,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ThemeColors.redFE3D2F,
                ),
                height: 24,
                width: 24,
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: ThemeColors.greyF7F7F7,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          )
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: IconButton(
          //       padding: EdgeInsets.symmetric(horizontal: 12),
          //       constraints: BoxConstraints(),
          //       icon: Image.asset(
          //         'assets/images/icons/more.png',
          //         height: 24,
          //         width: 24,
          //       ),
          //       onPressed: () {}),
          // ),
        ],
      ),
    );
  }

  Future showDialogFromBottom(context, {required Widget child}) async {
    return await showGeneralDialog(
      barrierLabel: 'Manage category',
      barrierDismissible: true,
      barrierColor: Color(0xFF474747).withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          ),
        );
      },
    );
  }

  Future showDialogFromNowhere(context, {required Widget child}) async {
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

  _onCategoryLongPress(BuildContext context, Category category, bool showSub) {
    HapticFeedback.mediumImpact();

    showDialogFromNowhere(context,
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
                    if (hasTextOverflow(
                      '${category.title}',
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxWidth: size.maxWidth,
                    ))
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
                    return Container();
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
                      openFromDhaza(context, category);
                      // openEditCategoryDialog(context, category);
                      // thing(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 24),
                      child: Row(
                        children: [
                          Text(
                            'Rename Cat...',
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
                            builder: (context) =>Container() /* AddScripturePage(
                              category: category,
                            ) */,
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
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          SlideFromRightPageRoute(
                              widget: Container()/* CategoryNotePage(
                            category: category,
                          ) */),
                        );
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
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: Container() /* AddScriptureToSubCategoryPage(
                              parent: category,
                            ) */),
                          );
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
                      if (await (deleteCategoryDialog(context, category))) {
                        Provider.of<IbDrawerController>(context, listen: false)
                            .select(1);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              category: Category(
                                id: 2,
                                title: 'Favorite',
                              ),
                            ),
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

  _toggleExpanded(Category category) {
    setState(() {
      if (category.id != this.expandedCategory)
        this.expandedCategory = category.id;
      else
        this.expandedCategory = null;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<ShareController>(context, listen: false).fetchScriptures();
    //Provider.of<CategoryController>(context, listen: false).getAll();
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<ShareController>(context, listen: false).fetchScriptures();
    //Provider.of<CategoryController>(context, listen: false).getAll();
  }
}
 */
}
