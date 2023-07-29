import 'dart:ui';

//import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/selected_item/selected_item_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/note_model.dart';
import 'package:ible/ui/pages/add_scripture_page_new.dart';
import 'package:ible/ui/pages/category_page.dart';
import 'package:ible/ui/pages/notes_page.dart';
import 'package:ible/ui/pages/settings_page.dart';
import 'package:ible/ui/pages/sign_in.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/utils/cat_long_press.dart';
import 'dart:math' as math;
import '../../theme.dart';
import 'dcupertino_overflow_menu.widget.dart';
import 'drawer_list_item.widget.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  String? expandedCategory = "-1";
  int selectedIndex = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFF343433),
      child: BlocBuilder<SelectedItemBloc, SelectedItemState>(
        builder: (context, state) {
          print(state.status);
          return SafeArea(
            child: Column(
              children: [
                buildDrawerHeader(context),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: ThemeColors.grey2E3235),
                      child: SafeArea(
                          bottom: false,
                          left: false,
                          right: false,
                          child: Column(
                            children: [
                              DrawerListItem(
                                selected: /* drawerController.selectedId == 1 */
                                    state.selectedItemType ==
                                            SelectedItemType.Category
                                        ? (state.selectedItem as Category)
                                                .id
                                                .toString() ==
                                            1.toString()
                                        : false,
                                title: 'Memory Verses',
                                onTap: () {
                                  BlocProvider.of<SelectedItemBloc>(context)
                                      .add(SelectedItemEventSelectItem(
                                          item: BlocProvider.of<CategoriesBloc>(
                                                      context)
                                                  .state
                                                  .memoryVersesCategory ??
                                              Category.memory()));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                          category:
                                              BlocProvider.of<CategoriesBloc>(
                                                          context)
                                                      .state
                                                      .memoryVersesCategory ??
                                                  Category.memory()),
                                    ),
                                  );
                                },
                                iconWidget: Image.asset(
                                  'assets/images/icons/memory_verses.png',
                                  width: 24,
                                ),
                              ),
                              DrawerListItem(
                                selected: /* drawerController.selectedId == 2 */
                                    state.selectedItemType ==
                                            SelectedItemType.Category
                                        ? (state.selectedItem as Category)
                                                .id
                                                .toString() ==
                                            2.toString()
                                        : false,
                                title: 'Favorites',
                                onTap: () {
                                  BlocProvider.of<SelectedItemBloc>(context)
                                      .add(SelectedItemEventSelectItem(
                                          item: BlocProvider.of<CategoriesBloc>(
                                                      context)
                                                  .state
                                                  .favoriteCategory ??
                                              Category.favorite()));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                          category:
                                              BlocProvider.of<CategoriesBloc>(
                                                          context)
                                                      .state
                                                      .favoriteCategory ??
                                                  Category.favorite()),
                                    ),
                                  );
                                },
                                iconWidget: Image.asset(
                                  'assets/images/icons/favorites.png',
                                  width: 24,
                                ),
                              ),
                              Expanded(
                                child: RawScrollbar(
                                  thumbColor: ThemeColors.greyABABAB,
                                  radius: Radius.circular(8),
                                  thickness: 4,
                                  child: BlocBuilder<CategoriesBloc,
                                      CategoriesState>(
                                    builder: (context, state1) {
                                      state1.categories?.removeWhere(
                                          (element) =>
                                              element.id == 1.toString() ||
                                              element.id == 2.toString());
                                      return ListView.builder(
                                        // padding: EdgeInsets.zero,
                                        key: UniqueKey(),
                                        itemCount: state1.categories?.length,
                                        itemBuilder: (context, index) {
                                          if ((state1.categories?.length ??
                                                  -1) >
                                              0)
                                            return buildListTitle(
                                                context,
                                                index,
                                                state,
                                                state1.categories![index]);
                                          else
                                            return Container();
                                        },
                                      );
                                      //  },
                                      // );
                                    },
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
                                        widget: AddScripturePageNew(
                                          isSubCategory: false,
                                        ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    side: BorderSide(
                                        width: 2, color: Color(0xFFCACADA)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 13),
                                    child: Text(
                                      'Add Verse',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
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
                          )))
                  /* ListView(children: [
                        
                            
                      ],) */
                  ,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _findIfOpen(bool hasChildren, SelectedItemState selectedItemState,
      Category category) {
    if (hasChildren == false) {
      return false;
    }
    if ((category.notes?.isNotEmpty ?? false) &&
        selectedItemState.selectedItemType ==
            SelectedItemType.Note) if (category.notes?[0].id.toString() ==
        (selectedItemState.selectedItem as NoteModel).id.toString()) {
      return true;
    }

    bool isOpen = false;
    for (int i = 0; i < (category.subCategories?.length ?? 0); i++) {
      if (selectedItemState.selectedItemType ==
          SelectedItemType.Category) if (category.subCategories?[i].id
              .toString() ==
          (selectedItemState.selectedItem as Category).id.toString()) {
        isOpen = true;
        break;
      } else if (selectedItemState.selectedItemType == SelectedItemType.Note &&
          (category.subCategories?[i].notes?.isNotEmpty ?? false)) {
        if (category.subCategories?[i].notes?[0].id.toString() ==
            (selectedItemState.selectedItem as NoteModel).id.toString())
          isOpen = true;
        break;
      }
    }

    return isOpen;
  }

  buildListTitle(BuildContext context, int index,
      SelectedItemState selectedItemState, Category category) {
    //final expandedCategory = "-1";

    final hasChildren = 0 < (category.subCategories?.length ?? 0);
    final hasNote = category.notes?.isNotEmpty ?? false;

    final showTrailing = hasChildren || hasNote;
    bool isOpen = this.expandedCategory == category.id;
    if (!isOpen) {
      isOpen = _findIfOpen(hasChildren, selectedItemState, category);
    }

    return Column(
      children: [
        DrawerListItem(
          trailingIconWidget: showTrailing
              ? InkWell(
                  child: Transform.rotate(
                    angle: isOpen ? math.pi / 2 : 0,
                    child: ImageIcon(
                      AssetImage('assets/images/icons/arrow_right.png'),
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => _toggleExpanded(category),
                )
              : null,
          count: category.subCategories?.length ?? 0,
          selected: selectedItemState.selectedItemType ==
                  SelectedItemType.Category
              ? (selectedItemState.selectedItem as Category).id.toString() ==
                  category.id.toString()
              : false,
          title: '${category.title}',
          onTap: () {
            BlocProvider.of<SelectedItemBloc>(context)
                .add(SelectedItemEventSelectItem(item: category));
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
          onLongPress: () => onCategoryLongPress(context, category, true),
        ),
        if (isOpen && hasChildren)
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: ListView.builder(
                itemCount: category.subCategories!.length,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  final subCategory = category.subCategories![position];
                  return Column(
                    children: [
                      DrawerListItem(
                        selected: selectedItemState.selectedItemType ==
                                SelectedItemType.Category
                            ? (selectedItemState.selectedItem as Category)
                                    .id
                                    .toString() ==
                                subCategory.id.toString()
                            : false,
                        title: '${subCategory.title}',
                        iconWidget: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5))),
                        onTap: () {
                          BlocProvider.of<SelectedItemBloc>(context).add(
                              SelectedItemEventSelectItem(item: subCategory));
                          /* BlocProvider.of<ScripturesBloc>(context).add(
                              ScripturesEventSelectCategory(
                                  category: subCategory)); */
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
                        onLongPress: () =>
                            onCategoryLongPress(context, subCategory, false),
                      ),
                      if (subCategory.notes?.isNotEmpty ?? false)
                        DrawerListItem(
                          selected: selectedItemState.selectedItemType ==
                                  SelectedItemType.Note
                              ? (selectedItemState.selectedItem as NoteModel)
                                      .id
                                      .toString() ==
                                  subCategory.notes![0].id.toString()
                              : false,
                          onTap: () async {
                            BlocProvider.of<SelectedItemBloc>(context).add(
                                SelectedItemEventSelectItem(
                                    item: subCategory.notes?[0]));
                            Navigator.push(
                              context,
                              SlideFromRightPageRoute(
                                  widget: NotePage(
                                note: subCategory.notes?[0],
                              )),
                            );
                          },
                          iconWidget: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: ImageIcon(
                              AssetImage('assets/images/icons/note.png'),
                              color: ThemeColors.grey808082,
                            ),
                          ),
                          title: 'Note',
                        ),
                    ],
                  );
                }),
          ),
        if (isOpen && hasNote)
          Column(
            children: category.notes
                    ?.map(
                      (e) => DrawerListItem(
                        selected: selectedItemState.selectedItemType ==
                                SelectedItemType.Note
                            ? (selectedItemState.selectedItem as NoteModel)
                                    .id
                                    .toString() ==
                                category.notes![0].id.toString()
                            : false,
                        onTap: () async {
                          BlocProvider.of<SelectedItemBloc>(context).add(
                              SelectedItemEventSelectItem(
                                  item: category.notes?[0]));
                          Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: NotePage(
                              note: category.notes?[0],
                            )),
                          );
                        },
                        iconWidget: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0),
                          child: ImageIcon(
                            AssetImage('assets/images/icons/note.png'),
                            color: ThemeColors.grey808082,
                          ),
                        ),
                        title: 'Note',
                      ),
                    )
                    .toList() ??
                [],
          ),
      ],
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
                          SlideFromRightPageRoute(widget: SettingsPage()));
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
                          SlideFromRightPageRoute(widget: LoginPage()));
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

  _toggleExpanded(Category category) {
    setState(() {
      if (category.id != this.expandedCategory)
        this.expandedCategory = category.id;
      else
        this.expandedCategory = null;
    });
  }
}
