import 'dart:ui';

//import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/notes/notes_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/blocs/verse/verse_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/note_model.dart';
import 'package:ible/ui/pages/add_scripture_page.dart';
import 'package:ible/ui/pages/add_scripture_page_new.dart';
import 'package:ible/ui/pages/category_page.dart';
import 'package:ible/ui/pages/settings_page.dart';
import 'package:ible/ui/pages/sign_in.dart';
import 'package:ible/ui/widgets/custom_tree_view.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/utils/delete_cat.dart';
import 'package:ible/utils/rename_cat.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
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
      child: Consumer<IbDrawerController>(
        builder: (context, _drawerController, widget) {
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
                                selected: /* drawerController.selectedId == 1 */ _drawerController
                                        .selectedId ==
                                    "1",
                                title: 'Memory Verses',
                                onTap: () {
                                  Provider.of<IbDrawerController>(context,
                                          listen: false)
                                      .select("1");

                                  BlocProvider.of<CategoriesBloc>(context)
                                      .add(CategoriesEventSelectCategory(
                                    category: BlocProvider.of<CategoriesBloc>(context).state.memoryVersesCategory ?? Category.memory()
                                  ));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                        category: BlocProvider.of<CategoriesBloc>(context).state.memoryVersesCategory ?? Category.memory()
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
                                selected: /* drawerController.selectedId == 2 */ _drawerController
                                        .selectedId ==
                                    "2",
                                title: 'Favorites',
                                onTap: () {
                                  Provider.of<IbDrawerController>(context,
                                          listen: false)
                                      .select("2");
                                  BlocProvider.of<CategoriesBloc>(context)
                                      .add(CategoriesEventSelectCategory(
                                    category: BlocProvider.of<CategoriesBloc>(context).state.favoriteCategory ?? Category.favorite()
                                  ));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                        category: BlocProvider.of<CategoriesBloc>(context).state.favoriteCategory ?? Category.favorite()
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
                                  child: BlocBuilder<CategoriesBloc,
                                      CategoriesState>(
                                    builder: (context, state) {
                                     /*  return BlocBuilder<NotesBloc, NotesState>(
                                        builder: (context, state1) { */
                                         /*  print(state.categories?.length);
                                          state.categories?.forEach((element) {
                                            print(element.title);
                                            print(element.id);
                                          });
                                          List<Category>? parentCategories =
                                              state.categories
                                                  ?.where((element) =>
                                                      element.parent == null ||
                                                      element.parent == "null")
                                                  .toList();
                                          print(
                                              "length:${parentCategories?.length}");
                                          final subCategories = state.categories
                                              ?.where((element) =>
                                                  element.parent != "null" &&
                                                  element.parent != null)
                                              .toList();
                                          print(
                                              "length2:${subCategories?.length}");
                                          print(state1.notes?.length);
                                          final parentNotes = state1.notes
                                              ?.where((element) =>
                                                  element.parentId.toString() !=
                                                      "null" &&
                                                  element.subParentId
                                                          .toString() ==
                                                      "null")
                                              .toList();
                                          print(
                                              'length4:${parentNotes?.length}');
                                          final subNotes = state1.notes?.where(
                                              (element) =>
                                                  element.subParentId !=
                                                  "null");
                                          for (int i = 0;
                                              i < (subCategories?.length ?? 0);
                                              i++) {
                                            final subNotesLocal = subNotes
                                                ?.where((element) =>
                                                    element.subParentId ==
                                                    subCategories?[i].id)
                                                .toList();
                                            if (subNotesLocal?.isNotEmpty ??
                                                false) {
                                              subCategories?[i].notes = [];
                                              subCategories?[i]
                                                  .notes
                                                  ?.addAll(subNotesLocal ?? []);
                                            }
                                          }
                                          for (int i = 0;
                                              i <
                                                  (parentCategories?.length ??
                                                      0);
                                              i++) {
                                            final parentNotesLocal = parentNotes
                                                ?.where((element) =>
                                                    element.parentId ==
                                                    parentCategories?[i].id)
                                                .toList();
                                            if (parentNotesLocal?.isNotEmpty ??
                                                false) {
                                              parentCategories?[i].notes = [];
                                              parentCategories?[i]
                                                  .notes
                                                  ?.addAll(
                                                      parentNotesLocal ?? []);
                                            }

                                            final subCategorieslocal =
                                                subCategories?.where((element) {
                                              return element.parent
                                                      .toString() ==
                                                  parentCategories?[i]
                                                      .id
                                                      .toString();
                                            }).toList();

                                            if (subCategorieslocal
                                                    ?.isNotEmpty ??
                                                false) {
                                              parentCategories?[i].subCategories =
                                                  [];

                                              parentCategories?[i]
                                                  .subCategories
                                                  ?.addAll(
                                                      subCategorieslocal ?? []);
                                            }
                                          } */


                                          return ListView.builder(
                                            // padding: EdgeInsets.zero,
                                            itemCount: state.categories?.length,
                                            itemBuilder: (context, index) {
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

                                              if ((state.categories?.length ??
                                                      -1) >
                                                  0)
                                                return buildListTitle(
                                                    context,
                                                    index,
                                                    _drawerController,
                                                    state.categories![index]);
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
                                        widget: AddScripturePageNew(isSubCategory: false,),
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
                          ))

                      /* CustomTreeView(
                                items: [
                                  CustomTreeViewItem(
                                      onInvoked: (item) async {
                                        BlocProvider.of<ScripturesBloc>(context)
                                          .add(ScripturesEventSelectCategory(
                                        category: Category(
                                          id: 1,
                                          title: 'Memory Verses',
                                        ),
                                      ));
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CategoryPage(
                                              category: Category(
                                                id: 1,
                                                title: 'Memory Verses',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      leading: Image.asset(
                                        'assets/images/icons/memory_verses.png',
                                        width: 35,
                                      ),
                                      backgroundColor:
                                          fluent.ButtonState.resolveWith((states) {
                                        if (states.isPressing) {
                                          return ThemeColors.grey4A5151;
                                        }
          
                                        return Colors.transparent;
                                      }),
                                      content: Text(
                                        "Memory Verses",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: ThemeColors.greyBCBCCO,
                                                fontWeight: FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  CustomTreeViewItem(
                                    onInvoked: (item) async {
                                      BlocProvider.of<ScripturesBloc>(context)
                                          .add(ScripturesEventSelectCategory(
                                        category: Category(
                                          id: 2,
                                          title: 'Favorites',
                                        ),
                                      ));
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CategoryPage(
                                            category: Category(
                                              id: 2,
                                              title: 'Favorites',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    backgroundColor:
                                        fluent.ButtonState.resolveWith((states) {
                                      if (states.isPressing) {
                                        return ThemeColors.grey4A5151;
                                      }
                                      return Colors.transparent;
                                    }),
                                    leading: Image.asset(
                                      'assets/images/icons/favorites.png',
                                      width: 35,
                                    ),
                                    content: Text(
                                      "Favorites",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: ThemeColors.greyBCBCCO,
                                              fontWeight: FontWeight.normal),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]..addAll(state.categories?.map<CustomTreeViewItem>((e) {
                                      return CustomTreeViewItem(
                                          leading: Container(
                                            height: 30,
                                            width: 24,
                                          ),
                                          backgroundColor:
                                              fluent.ButtonState.resolveWith((states) {
                                            if (states.isPressing) {
                                              return ThemeColors.grey4A5151;
                                            }
                                            return Colors.transparent;
                                          }),
                                          onInvoked: (item)async{
                                            BlocProvider.of<ScripturesBloc>(context)
                                          .add(ScripturesEventSelectCategory(
                                        category:e
                                      ));
                                      Navigator.push( context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryPage(
                                            category: e
                                          ),
                                        ),
                                      );
                                          },
                                          content: Text(
                                            e.title ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: ThemeColors.greyBCBCCO,
                                                    fontWeight: FontWeight.normal),
                                            overflow: TextOverflow.ellipsis,
                                          ));
                                    }).toList() ??
                                    []),
                                
                                onItemInvoked: (item) async {
                                  print(item.isExpandable);
                                },
                                selectionMode: TreeViewSelectionMode.single);
                          }, */
                      )
                  /* ListView(children: [
                        
                            
                      ],) */
                  ,
                ),
                /* 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 42.0),
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.push(
                              context,
                              SlideFromBottomPageRoute(
                                widget: AddScripturePage(),
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
                      ), */
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
              ],
            ),
          );
        },
      ),
    );
  }

  buildListTitle(BuildContext context, int index,
      IbDrawerController drawerController, Category category) {
    //final expandedCategory = "-1";
    print('length of children 8');
    print(category.subCategories?.length);
    final hasChildren = 0 < (category.subCategories?.length ?? 0);
    final hasNote = category.notes?.isNotEmpty ?? false;
    print(hasNote);
    final showTrailing = hasChildren || hasNote;
    bool isOpen = this.expandedCategory == category.id;
    if (hasChildren) {
      category.subCategories?.forEach((element) {
        if (element.id == drawerController.selectedId) {
          isOpen = true;
        }
      });
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
          selected: drawerController.selectedId == category.id,
          title: '${category.title}',
          onTap: () {
            Provider.of<IbDrawerController>(context, listen: false)
                .select(category.id ?? "");
            BlocProvider.of<CategoriesBloc>(context)
                .add(CategoriesEventSelectCategory(category: category));
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
        if (isOpen && hasChildren)
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: ListView.builder(
                itemCount: category.subCategories!.length,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  final subCategory = category.subCategories![position];
                  return Column(
                    children: [
                      DrawerListItem(
                        selected: drawerController.selectedId == subCategory.id,
                        title: '${subCategory.title}',
                        iconWidget: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5))),
                        onTap: () {
                          Provider.of<IbDrawerController>(context,
                                  listen: false)
                              .select(subCategory.id ?? "");
                          BlocProvider.of<ScripturesBloc>(context).add(
                              ScripturesEventSelectCategory(
                                  category: subCategory));
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
                            _onCategoryLongPress(context, subCategory, false),
                      ),
                      if (subCategory.notes?.isNotEmpty ?? false)
                        InkWell(
                          onTap: () async {
                            //TODO: CLOSE THE DRAWER HERE.
                            /* Navigator.push(
                                  context,
                                  SlideFromRightPageRoute(
                                      widget: CategoryNotePage(
                                    category: subCategory,
                                  )),
                                ); */
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
        if (isOpen && hasNote)
          Column(
            children: category.notes?.map((e) => 
              InkWell(
                onTap: () async {
                  //TODO: CLOSE THE DRAWER HERE.
                  /*  Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: CategoryNotePage(
                                  category: category,
                                )),
                              ); */
                },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 46)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                      child: ImageIcon(
                        AssetImage('assets/images/icons/note.png'),
                        color: ThemeColors.grey808082,
                      ),
                    ),
                    Text(
                      e.title ?? "",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: ThemeColors.greyBCBCCO,
                          ),
                    ),
                  ],
                ),
              ),).toList() ??[],
            
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
                    /* if (hasTextOverflow(
                      '${category.title}',
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxWidth: size.maxWidth,
                    )) */
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
                      renameCategory(context, category);
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
                  CupertinoActionSheetAction(
                      onPressed: () {
                        final newNote = NoteModel(
                            id: Uuid().v1(),
                            parentId:
                                category.parent.toString() == "null" ? category.id : null,
                            subParentId:
                                category.parent.toString() != "null" ? category.id : null,
                            createdAt: DateTime.now(),
                            title: "Note 1");
                        BlocProvider.of<NotesBloc>(context)
                            .add(NotesEventSaveNote(note: newNote));
                        Navigator.pop(context);
                        /* Navigator.push(
                          context,
                          SlideFromRightPageRoute(
                              widget: CategoryNotePage(
                            category: category,
                          )),
                        ); */
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
                          final newCategory = Category(
                             
                              id: Uuid().v1(),
                              parent: category.id,
                              title: "Sub cat");
                          BlocProvider.of<CategoriesBloc>(context).add(
                              CategoriesEventAddCategory(
                                  category: newCategory));
                          Navigator.pop(context);

                          /*  Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: AddScriptureToSubCategoryPage(
                              parent: category,
                            )),
                          ); */
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 24),
                          child: Row(
                            children: [
                              Text('Add Subcat...'),
                              Spacer(),
                              ImageIcon(
                                AssetImage(
                                    'assets/images/icons/subcategory.png'),
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
                            .select("2"); 
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              category: Category(
                                id: "2",
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
}

class IbDrawerController with ChangeNotifier {
  String selectedId = "2";

  select(String id) {
    this.selectedId = id;
    notifyListeners();
  }
}
