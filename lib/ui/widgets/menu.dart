import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/ui/pages/add_scripture_page.dart';
import 'package:ible/ui/pages/category.page.dart';
import 'package:ible/ui/pages/settings_page.dart';
import 'package:ible/ui/pages/sign_in.dart';
import 'package:ible/ui/widgets/custom_tree_view.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';

import '../../theme.dart';
import 'dcupertino_overflow_menu.widget.dart';
import 'drawer_list_item.widget.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xFF343433),
      child: SafeArea(
        child: Column(
          children: [
            buildDrawerHeader(context),

            Expanded(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  return CustomTreeView(
                      items: [
                        CustomTreeViewItem(
                            onInvoked: (item) async {
                              BlocProvider.of<ScripturesBloc>(context)
                                .add(ScripturesEventSelectCategory(
                              category: Category(
                                id: 1,
                                title: 'Memory Verse',
                              ),
                            ));
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
                              "Memory Verse",
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
                                title: 'Favorite',
                              ),
                            ));
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
                            "Favorite",
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
                },
              )
              /* ListView(children: [
              
                  
            ],) */
              ,
            ),

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
          ],
        ),
      ),
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
}
