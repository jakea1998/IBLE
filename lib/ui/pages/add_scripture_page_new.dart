import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/blocs/verse/verse_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/category_editor_disabled.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/category_editor_enabled.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/category_tab_widget.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/save_button.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/subcategory_tab_widget.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/verse_display.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/verse_editor.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/categories/categories_bloc.dart';
import '../../utils/pick_cat_dialog.dart';

class AddScripturePageNew extends StatefulWidget {
  final Category? category;
  final Category? parentCategory;
  final bool isSubCategory;
  const AddScripturePageNew(
      {Key? key,
      this.category,
      this.parentCategory,
      required this.isSubCategory})
      : super(key: key);

  @override
  State<AddScripturePageNew> createState() => _AddScripturePageNewState();
}

class _AddScripturePageNewState extends State<AddScripturePageNew>
    with SingleTickerProviderStateMixin {
  late TabController _upTabController;
  late Category? _selectedCategory;
  String _categoryHintText = "Type new category name";
  late TextEditingController _categoryTextEditingController;

  TextEditingController _verseTextEditingController = TextEditingController();
  late List<String> titles;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._selectedCategory = widget.category;
    _upTabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: this._selectedCategory != null ? 1 : 0);

    _verseTextEditingController
      ..addListener(() {
       
        
        context.read<VerseBloc>().add(VerseEventSearchVerse(
            query: _verseTextEditingController.text,
            bibleVersion:
                BlocProvider.of<BibleVersionBloc>(context).state.savedVersion ??
                    Data.defaultVersion()));
      });
    _categoryTextEditingController =
        TextEditingController(text: widget.category?.title ?? "");
    _categoryTextEditingController
      ..addListener(() {
        Category category1 = Category(
          id: Uuid().v1(),
          parent: widget.isSubCategory ? widget.parentCategory?.id : null,
          title: _categoryTextEditingController.text,
        );

        BlocProvider.of<VerseBloc>(context)
          ..add(VerseEventUpdateCategory(category: category1));
      });
    _upTabController.addListener(() {
      _selectedCategory = null;
      _categoryTextEditingController.clear();
      setState(() {});
    });
    if (this._selectedCategory != null) {
      BlocProvider.of<VerseBloc>(context)
        ..add(VerseEventUpdateCategory(category: this._selectedCategory));

      this._categoryTextEditingController.text = this._selectedCategory!.title!;
    }
  }

  Widget _buildExitRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 12, bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ImageIcon(
              AssetImage('assets/images/icons/close.png'),
              color: ThemeColors.greyC2C2C2,
            ),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  final divider = Divider(
    color: ThemeColors.greyC2C2C2,
    thickness: 1,
  );
  void _launchPopup(
      {required BuildContext context, required List<Category> categories}) {
    showPickCategoryDialog(
        context: context,
        categories: categories,
        memoryVerseTapped: () {
          //memory verse

          setState(() {
            _selectedCategory = BlocProvider.of<CategoriesBloc>(context)
                .state
                .memoryVersesCategory;
            _categoryTextEditingController.text =
                BlocProvider.of<CategoriesBloc>(context)
                        .state
                        .memoryVersesCategory
                        ?.title ??
                    "Memory Verses";
          });
        },
        newCatTapped: () {
          //new cat tapped

          setState(() {
            _upTabController.index = 0;

            _categoryTextEditingController.clear();
            _selectedCategory = null;
          });
        },
        showNewCat: true,
        favoriteVerseTapped: () {
          // fav verse

          setState(() {
            _selectedCategory =
                BlocProvider.of<CategoriesBloc>(context).state.favoriteCategory;
            _categoryTextEditingController.text =
                BlocProvider.of<CategoriesBloc>(context)
                        .state
                        .favoriteCategory
                        ?.title ??
                    "Favorites";
          });
        },
        catTapped: (cat) {
          // other cat tapped

          setState(() {
            _selectedCategory = cat;
            _categoryTextEditingController.text = cat.title ?? "";
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> cats = []..addAll(BlocProvider.of<CategoriesBloc>(context)
            .state
            .categoriesAndSubCategories ??
        []);
    cats.removeWhere((element) =>
        element.title?.toLowerCase() == "favorites" ||
        element.title?.toLowerCase() == "memory verses");

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildExitRow(),
                      widget.isSubCategory
                          ? SubCategoryTabWidget()
                          : CategoryTabWidget(
                              tabController: _upTabController,
                            ),
                      _upTabController.index == 0
                          ? IgnorePointer(
                              ignoring: widget.isSubCategory &&
                                  widget.category != null,
                              child: CategoryEditorEnabled(
                                key: UniqueKey(),
                                hintText: !widget.isSubCategory
                                    ? "Type New Category Name"
                                    : "Type New Subcategory Name",
                                categoryTextEditingController:
                                    _categoryTextEditingController,
                              ))
                          : CategoryEditorDisabled(
                              key: UniqueKey(),
                              hintText: "Choose Category",
                              onTap: () => _launchPopup(
                                  categories: cats, context: context),
                              categoryTextEditingController:
                                  _categoryTextEditingController,
                            ),
                      divider,
                      VerseEditor(
                        verseTextEditingController: _verseTextEditingController,
                        validator: (p0) {
                          if (p0 == "" ||
                              (BlocProvider.of<VerseBloc>(context)
                                          .state
                                          .verses
                                          ?.length ??
                                      0) ==
                                  0) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        height: 0.5,
                        color: ThemeColors.greyB2B2B2,
                      ),
                      VerseDisplay(),
                      divider,
                      SaveButton(onPressed: () async{
                        if (_formKey.currentState?.validate() ?? false) {
                          if (widget.isSubCategory &&
                              BlocProvider.of<CategoriesBloc>(context)
                                      .state
                                      .subCategoriesTitles
                                      ?.indexWhere((element) =>
                                          element.toLowerCase() ==
                                          _categoryTextEditingController.text
                                              .toLowerCase()) !=
                                  -1) {
                            showNotificationDialog(
                                context, "Subcategory already exists");
                            return;
                          } else if (BlocProvider.of<CategoriesBloc>(context)
                                  .state
                                  .categoriesAndSubCategoriesTitles
                                  ?.indexWhere((element) =>
                                      element.toLowerCase() ==
                                      _categoryTextEditingController.text
                                          .toLowerCase()) !=
                              -1) {
                            showNotificationDialog(
                                context, "Category already exists");
                            return;
                          } else {
                            BlocProvider.of<VerseBloc>(context).add(
                                VerseEventSaveScripture(
                                    bibleVersion:
                                        BlocProvider.of<BibleVersionBloc>(
                                                    context)
                                                .state
                                                .savedVersion ??
                                            Data.defaultVersion(),
                                    verses: BlocProvider.of<VerseBloc>(context)
                                            .state
                                            .verses ??
                                        [],
                                    isNew: _categoryHintText ==
                                        "Type new category name"));

                            Navigator.pop(context);
                            await showNotificationDialog(context,
                                "Saved to ${_categoryTextEditingController.text}");
                          }
                        }
                      })
                    ]))));
  }
}
