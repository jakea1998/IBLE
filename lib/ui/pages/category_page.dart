import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';

import 'package:ible/models/bible_version.dart';

import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';

import 'package:ible/theme.dart';
import 'package:ible/ui/pages/add_scripture_page_new.dart';
import 'package:ible/ui/widgets/categories_menu_popup.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:ible/ui/widgets/no_scriptures_saved.dart';
import 'package:ible/ui/widgets/scripture_result_list_item.dart';
import 'package:ible/ui/widgets/scripture_widget.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/ui/widgets/sliding_scaffold_new.dart';
import 'package:ible/utils/pick_cat_dialog.dart';

import '../../blocs/scriptures/scriptures_bloc.dart';

class CategoryPage extends StatefulWidget {
  final Category? category;
  final String? message;

  const CategoryPage({Key? key, this.category, this.message}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  Category? category;
  late SlidableController slidableController;

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
      appBarColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (widget.category?.parent != "null" && widget.category?.parent != null)
              ? Padding(
                  padding: EdgeInsets.only(right: 7, bottom: 12),
                  child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5))),
                )
              : Container(),
          Text(
            widget.category?.title ?? '',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      ),
      onWillOpen: () {
        /*  if (slidableController.) {
          slidableController.activeState?.close();
          return false;
        } else
          return true; */
      },
      actions: [
        CategoriesMenuPopup(category: widget.category ?? Category.favorite()),
        Padding(
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
        ),
      ],
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: (state.selectedCategory?.verses?.length ?? 0) > 0
                ? ListView.separated(
                  padding: EdgeInsets.zero,
                    itemCount: state.selectedCategory?.verses?.length ?? 0,
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 16, top: 4, bottom: 4),
                        height: 0.5,
                        color: ThemeColors.greyB2B2B2,
                      );
                    },
                    itemBuilder: (context, index) {
                      print('index:$index');
                      print('categories');
                      final verse = BlocProvider.of<CategoriesBloc>(context)
                          .state
                          .selectedCategory
                          ?.verses?[index];
                      final categoriesAndSubCategories =
                          BlocProvider.of<CategoriesBloc>(context)
                              .state
                              .categoriesAndSubCategories
                            ?..removeWhere((element) =>
                                BlocProvider.of<CategoriesBloc>(context)
                                    .state
                                    .selectedCategory
                                    ?.id
                                    .toString() ==
                                element.id.toString());
                      List<Category> sharedCats = [];
                      List<Category> sharedSubCats = [];
                      categoriesAndSubCategories?.forEach((element) {
                        element.verses?.forEach((element1) {
                          if (element1.id.toString() == verse?.id.toString()) {
                            if (element.parent.toString() == "null")
                              sharedCats.add(element);
                            else
                              sharedSubCats.add(element);
                          }
                        });
                      });
                      return ScriptureWidget(
                        index: index,
                        slidableController: slidableController,
                        sharedCats: sharedCats,
                        sharedSubCats: sharedSubCats,
                        onMoveTapped: () {
                          final oldCategoryId =
                              BlocProvider.of<CategoriesBloc>(context)
                                  .state
                                  .selectedCategory
                                  ?.id
                                  .toString();
                          Category? newCategory;
                          showPickCategoryDialog(
                              context: context,
                              memoryVerseTapped: () {
                                if (BlocProvider.of<CategoriesBloc>(context)
                                        .state
                                        .memoryVersesCategory
                                        ?.id
                                        .toString() !=
                                    oldCategoryId.toString()) {
                                  newCategory =
                                      BlocProvider.of<CategoriesBloc>(context)
                                          .state
                                          .memoryVersesCategory;
                                }
                              },
                              categories:
                                  state.categoriesAndSubCategories ?? [],
                              newCatTapped: () {},
                              showNewCat: false,
                              favoriteVerseTapped: () {
                                if (BlocProvider.of<CategoriesBloc>(context)
                                        .state
                                        .favoriteCategory
                                        ?.id
                                        .toString() !=
                                    oldCategoryId.toString()) {
                                  newCategory =
                                      BlocProvider.of<CategoriesBloc>(context)
                                          .state
                                          .favoriteCategory;
                                }
                              },
                              catTapped: (cat) {
                                if (cat.id.toString() !=
                                    oldCategoryId.toString()) {
                                  newCategory = cat;
                                }
                              });
                          if (newCategory != null) {
                            BlocProvider.of<ScripturesBloc>(context).add(
                                ScripturesEventMoveVerse(
                                    newCategory: newCategory!,
                                    oldCategory:
                                        BlocProvider.of<CategoriesBloc>(context)
                                            .state
                                            .selectedCategory ?? Category(),
                                    verse:
                                        BlocProvider.of<CategoriesBloc>(context)
                                            .state
                                            .selectedCategory!
                                            .verses![index]));
                            showNotificationDialog(
                                context, "Moved to ${newCategory?.title}");
                          }
                        },
                        selectedCategory:
                            state.selectedCategory ?? Category.favorite(),
                      );
                    },
                  )
                : NoScripturesSaved(),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            elevation: 0,
            backgroundColor: ThemeColors.greyA7B0B3,
            onPressed: ()async {
              
              Navigator.push(
                context,
                SlideFromBottomPageRoute(
                  widget: AddScripturePageNew(
                    parentCategory: BlocProvider.of<CategoriesBloc>(context)
                                .state
                                .selectedCategory
                                ?.parent
                                .toString() ==
                            "null"
                        ? null
                        : BlocProvider.of<CategoriesBloc>(context)
                            .state
                            .categories
                            ?.firstWhere((element) =>
                                element.id.toString() ==
                                BlocProvider.of<CategoriesBloc>(context)
                                    .state
                                    .selectedCategory
                                    ?.parent
                                    .toString()),
                    isSubCategory: BlocProvider.of<CategoriesBloc>(context)
                                .state
                                .selectedCategory
                                ?.parent
                                .toString() ==
                            "null"
                        ? false
                        : true,
                    category: widget.category ?? Category.favorite(),
                  ),
                ),
              );
            },
            child: Image.asset('assets/images/icons/Add_56x56_PNG.png'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    category = widget.category;
    slidableController = SlidableController(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.message != null) {
        showNotificationDialog(context, widget.message);
      }
    });
  }
}

/*   _buildNoteList(BuildContext context, List<Scripture>? notes) {
    return Scrollbar(
      child: ListView.separated(
        separatorBuilder: (context, pos) => Padding(
          padding: EdgeInsets.only(left: 16),
          child: Container(
            color: ThemeColors.greyABABAB,
            height: 1,
          ),
        ),
        itemBuilder: (context, pos) {
          final scripture = notes![pos];
          return InkWell(
            onTap: () {
              if (slidableController.activeState != null) {
                slidableController.activeState?.close();
                return;
              }
              /*  Provider.of<ScriptureController>(context, listen: false)
                    .currentScripture = scripture;
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => ScripturePage(scripture: scripture),
                      ),
                    )
                    .then((value) =>
                        Provider.of<CategoryController>(context, listen: false)
                            .refresh()); */
            },
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              controller: slidableController,
              actionExtentRatio: 0.20,
              child: Container(
                padding:
                    EdgeInsets.only(left: 16.0, top: 16, bottom: 16, right: 16),
                color: Theme.of(context).backgroundColor,
                child:
                    Container() /* ScriptureListItem(
                    scripture: scripture,
                  ) */
                ,
              ),
              actions: <Widget>[],
              secondaryActions: <Widget>[
                SlideAction(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        border: BorderDirectional(end: BorderSide())),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ImageIcon(
                              AssetImage('assets/images/icons/pin_top.png'),
                              color: Colors.white,
                            ),
                          ),
                          Flexible(
                            child: Text('PIN TOP',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .caption!
                                    .copyWith(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    /*  Provider.of<CategoryController>(context, listen: false)
                          .pinScripture(category!, scripture.id); */
                  },
                ),
                SlideAction(
                  color: Colors.grey[900],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: ImageIcon(
                        AssetImage('assets/images/icons/move_to.png'),
                        color: Colors.white,
                      )),
                      Flexible(
                        child: Text('MOVE TO',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .caption!
                                .copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                  onTap: () {
                   showPickCategoryDialog(scripture);
                  },
                ),
                SlideAction(
                  color: ThemeColors.redDD4C4F,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ImageIcon(
                          AssetImage('assets/images/icons/delete.png'),
                          color: Colors.white,
                        ),
                      ),
                      Flexible(
                        child: Text('DELETE',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .caption!
                                .copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                  onTap: () async {
                    deleteScriptureDialog(context,scripture.);
                  },
                ),
              ],
            ),
          );
        },
        itemCount: notes!.length,
      ),
    );
  } */



