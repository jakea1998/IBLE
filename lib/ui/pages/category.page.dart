import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:ible/models/category_model.dart';
import 'package:ible/models/scripture_model.dart';

import 'package:ible/theme.dart';
import 'package:ible/ui/pages/add_scripture_page.dart';
import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:ible/ui/widgets/slide_from_bottom_page_route.widget.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/ui/widgets/sliding_scaffold.widget.dart';

import 'package:provider/provider.dart';



class CategoryPage extends StatefulWidget {
  final Category? category;
  final String? message;

  const CategoryPage({Key? key, this.category, this.message}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Category? category;
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
      // drawer: IbleDrawer(),
     /*  appBar: AppBar(
        title: Text(widget.category?.title ?? '',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ImageIcon(
                                AssetImage('assets/images/icons/menu.png'),
                                color: ThemeColors.appBarIconColor,
                                size: Theme.of(context).iconTheme.size,
                              ),
                            ),), */
      
       actions: [
          IconButton(icon: Icon(Icons.more_vert,color: ThemeColors.appBarIconColor,),onPressed: (){},),
          IconButton(icon: Icon(Icons.ios_share,color: ThemeColors.appBarIconColor,),onPressed: (){},),
        ],
        appBarColor: Colors.white,
        title: Text(widget.category?.title ?? '',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
       onWillOpen: () {
          if (slidableController.activeState != null) {
            slidableController.activeState?.close();
            return false;
          } else
            return true;
        },
      body: Builder(builder: (context) {
        return Container(color: Colors.white,);
        /*  if (!controller.initialised) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Wait, loading'),
              );
            } else if (controller.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Something does not feel right'),
              );
            }
            if (controller.notes?.isEmpty ?? true)
              return Center(
                child: Text('No scriptures saved.'),
              );
            return _buildNoteList(context, controller.notes);
          }, */
      }),
     
      
      /*   onTap: /* (controller.currentCategory?.parent ?? category!.parent) != null
            ? () {
                if (category!.parent == null)
                  Navigator.push(
                    context,
                    SlideFromRightPageRoute(
                        widget: CategoryPage(
                      category: Category(
                        id: controller.currentCategory?.parent ??
                            category!.parent!,
                      ),
                    )),
                  );
              }
            :  */null, */
        /* onLongPress: () {
         /*  print(controller.currentCategory?.parent ??
              category!.parent ??
              'Not a child'); */
          showPersistentDialogFromBottom(
            context,
            child: Container(
              margin: EdgeInsets.only(top: 128, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Theme.of(context).backgroundColor),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'CATEGORY NAME',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: ThemeColors.grey595959,
                                    fontSize: 20,
                                  ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Image.asset('assets/images/icons/close.png'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        /* controller.currentCategory?.title ?? category!.title! */'',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: ThemeColors.grey595959,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, */
      /*   : Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              /* controller.currentCategory?.title ?? category!.title! */'',
              style: AppStyles.titleStyle(context),
            ),
            if (/* controller.currentCategory?.parent != null ||
                category!.parent != null */true)
              Positioned(
                left: -15,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.blue027CFE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 10,
                    width: 10,
                  ),
                ),
              )
          ],
        ),
      ), */
      /* actions: [
        Padding(
          padding: EdgeInsets.only(right: 0.0),
          child: DCupertinoOverflowMenu(
            children: [
              if (this.widget.category!.id != 1 &&
                  this.widget.category!.id != 2)
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    openFromDhaza(context, category);
                  },
                  child: Text('Edit Name'),
                ),
              if (this.widget.category!.id != 1 &&
                  this.widget.category!.id != 2)
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: ThemeColors.grey9B9B9B,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        message: Text(
                          'Transfer category scriptures to note?',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget:
                                        /* CategoryNotePage(
                                        category: category,
                                        scriptures: []), */
                                        Container()),
                              ).then((value) {
                                if (value) _copyScripturesFromNote();
                              });
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text(
                              'No',
                              style: TextStyle(color: ThemeColors.blue027CFE),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                SlideFromRightPageRoute(widget: Container()),
                              ).then((value) {
                                if (value) _copyScripturesFromNote();
                              });
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Text('Add Note'),
                ),
              if (this.widget.category!.id != 1 &&
                  this.widget.category!.id != 2 &&
                  this.widget.category?.parent == null)
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        SlideFromRightPageRoute(widget: Container()),
                      );
                    },
                    child: Text('Add Sub category')),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  final scriptures = [];
                  var list = '';
                  scriptures.forEach((scripture) {
                    list += '\n\n${scripture.print}';
                  });
                  Clipboard.setData(ClipboardData(text: list.trim()));
                },
                child: Text('Copy Scripture List'),
              ),
              if (this.widget.category!.id != 1 &&
                  this.widget.category!.id != 2)
                CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.pop(context);
                    final del = await deleteCategoryDialog(context, category);

                    Navigator.pushReplacement(
                        context,
                        SlideFromRightPageRoute(
                            widget: CategoryPage(
                          category: Category(id: 2, title: 'Favs'),
                        )));
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
        ),
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
      ], */
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: ThemeColors.greyA7B0B3,
              onPressed: () {
                Navigator.push(
                  context,
                  SlideFromBottomPageRoute(
                    widget: AddScripturePage(category: Category(id: category?.id,title:category?.title),),
                  ),
                );
              },
              child: Image.asset('assets/images/icons/Add_56x56_PNG.png'),
            ),
          ),
        ],
      ), 
    );
  }

  _showSnackBar(String content) {
    print(content);
  }

  _buildNoteList(BuildContext context, List<Scripture>? notes) {
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
                    _openPickCrossDialog(scripture);
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
                    deleteScriptureDialog(context, scripture);
                  },
                ),
              ],
            ),
          );
        },
        itemCount: notes!.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    category = widget.category;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      /*  Provider.of<CategoryController>(
        context,
        listen: false,
      ).getScriptures(category!.id);
      Provider.of<IbDrawerController>(
        context,
        listen: false,
      ).select(category!.id); */
      if (widget.message != null) {
        showNotificationDialog(context, widget.message);
      }
    });
  }

  _openPickCrossDialog(Scripture scripture) {
    showPersistentDialogFromBottom(
      context,
      child: Dialog(
        // backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        insetPadding: EdgeInsets.only(
          left: 0,
          right: 0,
          bottom: 0,
          top: 48,
        ),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Theme.of(context).backgroundColor),
            child:
                Container() /* FutureBuilder<List<Category>>(
            future: Future.wait(Duration(hours: 1))/* Provider.of<CategoryRepository>(context, listen: false)
                .getAll() */,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              if (snapshot.hasData) {
                var categories = snapshot.data!;
                if (scripture.crossRefs != null)
                  categories.forEach((category) {
                    category.shaded =
                        scripture.crossRefs!.firstWhereOrNull((ref) {
                                  return ref.id == category.id;
                                }) !=
                                null ||
                            scripture.category == category.id;
                  });
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(null),
                        title: Text(
                          'CHOOSE CATEGORY',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: ThemeColors.grey595959,
                                    fontSize: 20,
                                  ),
                        ),
                        trailing: InkWell(
                          child: ImageIcon(
                              AssetImage('assets/images/icons/close.png')),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Builder(builder: (context) {
                        final bool active = (scripture.crossRefs == null ||
                                scripture.crossRefs!.firstWhereOrNull(
                                      (ref) => ref.id == 1,
                                    ) ==
                                    null) &&
                            scripture.category != 1;
                        final bool inactive = !active;
                        final bool self = scripture.category == 1;
                        return Align(
                          child: InkWell(
                            onTap: inactive
                                ? null
                                : () => _addToCross(
                                    context,
                                    scripture,
                                    Category(
                                      id: 1,
                                      title: 'Memory Verses',
                                    )),
                            child: Container(
                              color: active
                                  ? Colors.transparent
                                  : self
                                      ? ThemeColors.greyECECEC
                                      : ThemeColors.greyECECEC.withOpacity(0.5),
                              padding: EdgeInsets.all(15),
                              child: Center(
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
                        );
                      }),
                      Divider(
                        height: 0,
                      ),
                      Builder(builder: (context) {
                        final bool active = (scripture.crossRefs == null ||
                                scripture.crossRefs!.firstWhereOrNull(
                                      (ref) => ref.id == 2,
                                    ) ==
                                    null) &&
                            scripture.category != 2;
                        final bool inactive = !active;
                        final bool self = scripture.category == 2;
                        return Align(
                          child: InkWell(
                            onTap: inactive
                                ? null
                                : () => _addToCross(
                                    context,
                                    scripture,
                                    Category(
                                      id: 2,
                                      title: 'Favorite',
                                    )),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              color: active
                                  ? Colors.transparent
                                  : self
                                      ? ThemeColors.greyECECEC
                                      : ThemeColors.greyECECEC.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  'Favorites',
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
                        );
                      }),
                      Divider(
                        height: 0,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            separatorBuilder: (context, pos) =>
                                Divider(height: 0),
                            itemBuilder: (context, index) {
                              final bool active = (scripture.crossRefs ==
                                          null ||
                                      scripture.crossRefs!.firstWhereOrNull(
                                            (ref) =>
                                                ref.id == categories[index].id,
                                          ) ==
                                          null) &&
                                  scripture.category != categories[index].id;
                              final bool inactive = !active;
                              final bool self =
                                  scripture.category == categories[index].id;
                              return Align(
                                child: InkWell(
                                  onTap: inactive
                                      ? null
                                      : () => _addToCross(
                                            context,
                                            scripture,
                                            categories[index],
                                          ),
                                  child: Container(
                                    color: active
                                        ? Colors.transparent
                                        : self
                                            ? ThemeColors.greyECECEC
                                            : ThemeColors.greyECECEC
                                                .withOpacity(0.5),
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: Text(
                                        categories[index].title!,
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
                              );
                            },
                            itemCount: categories.length,
                            shrinkWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Text('Loading...');
            },
          ), */
            ),
      ),
    );
  }

  Future _addToCross(
      BuildContext context, Scripture scripture, Category category) async {
    Navigator.of(context).pop();
    /* await Provider.of<ScriptureController>(
      context,
      listen: false,
    ).addToCross(scripture, category.id);
    showNotificationDialog(this.context, 'Moved to ${category.title}');
    setState(() {
      Provider.of<CategoryController>(
        context,
        listen: false,
      ).refresh();
    }); */
  }

  Future _copyScripturesFromNote() async {
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
              showNotificationDialog(this.context, 'Scriptures copied');
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
}

editCategory(BuildContext context, Category? category) async {
  /* final edited = await Provider.of<CategoryController>(context, listen: false)
      .update(category); */
  /*  if (edited != null) {
    Navigator.of(context).pop();
    // BlocProvider.of<CategoryBloc>(context, listen: false).add(
    //   GetCategories(),
    // ); todo: Make sure that the CategoriesController works

    Provider.of<CategoryController>(context, listen: false).refresh();

    await showNotificationDialog(context, "Name Changed");
    // await showDialog(
    //   context: context,
    //   builder: (context) {
    //     return DNotificationDialog(
    //       content: 'Name Changed',
    //     );
    //   },
    // );
    return edited;
  } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Failed to edit')));
  } */
}

///Function deletes selected category from the database.
///
/// TODO: Implement proper notifications for actions taken.
/// TODO: Change background color for the cupertino  actionsheet item.
Future<bool> deleteCategoryDialog(
    BuildContext context, Category? category) async {
  final done = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: Container(
          child: Text(
            'Delete Category & Note?',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        message: Container(
          child: Text(
            'Deleting this category will delete it and it\'s note permanently.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(DeleteCategoryEvent(category));
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(GetCategories());
              /* final categoryController =
                  Provider.of<CategoryController>(context, listen: false); */
              /* await categoryController.delete(category!.id);
              categoryController.refresh(); */
              await showNotificationDialog(context, "Category Deleted");
              Navigator.pop(context, true);
            },
            child: Text('OK'),
            isDestructiveAction: true,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, false),
        ),
      );
    },
  );
  return done ?? false;
}

deleteScriptureDialog(BuildContext openContext, Scripture scripture) {
  showCupertinoModalPopup(
    context: openContext,
    builder: (context) {
      return CupertinoActionSheet(
        title: Container(
          child: Text(
            'Delete Scripture?',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        message: Container(
          child: Text(
            'Deleting this scripture will remove it permanently.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ThemeColors.grey808082,
                ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              /*  await Provider.of<ScriptureController>(context, listen: false)
                  .delete(scripture.id);
              await Provider.of<CategoryController>(context, listen: false)
                  .refresh(); */
              // BlocProvider.of<CategoryBloc>(context, listen: false)
              //     .add(GetCategories());
              showNotificationDialog(openContext, "Scripture Deleted");
            },
            child: Text('OK'),
            isDestructiveAction: true,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      );
    },
  );
}

void openFromDhaza(openContext, Category? category) => showGeneralDialog(
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
              // height: 300,
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
