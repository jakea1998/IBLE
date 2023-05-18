/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/repos/verse_repo.dart';
import 'package:ible/blocs/verse/verse_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/auth_text_input_field.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:ible/ui/widgets/scripture_result_list_item.dart';
import 'package:ible/ui/widgets/tab_indicator.dart';
import 'package:uuid/uuid.dart';

import 'category.page.dart';

class AddScripturePage extends StatefulWidget {
  final Category? category;

  const AddScripturePage({Key? key, this.category}) : super(key: key);

  @override
  _AddScripturePageState createState() => _AddScripturePageState();
}

class _AddScripturePageState extends State<AddScripturePage>
    with SingleTickerProviderStateMixin {
  TabController? _upTabController;
  Category? _selectedCategory;
  TextEditingController _verseTextEditingController = TextEditingController();
  int _selectedIndexValue = 0;
  final _formKey = GlobalKey<FormState>();
  String _categoryHintText = "Type new category name";
  TextEditingController _categoryTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _upTabController = TabController(length: 2, vsync: this);
    _upTabController!.addListener(() {
      setState(() {
        _selectedIndexValue = _upTabController!.index;
        _categoryHintText = _upTabController!.index == 0
            ? "Type new category name"
            : "Choose category";
        // _categoryTextEditingController.clear();
      });
    });
    _categoryTextEditingController
      ..addListener(() {
        final len =
            BlocProvider.of<CategoriesBloc>(context).state.categories?.length ??
                2;
        Category category1 = Category(
            id: Uuid().v1(),
            parent: null,
            title: _categoryTextEditingController.text,
            );
        print('update');
        BlocProvider.of<VerseBloc>(context)
          ..add(VerseEventUpdateCategory(category: category1));
      });
    if (this._selectedCategory != null) {
      this._selectedIndexValue = 1;
      this._upTabController!.index = 1;
      this._categoryTextEditingController.text = this._selectedCategory!.title!;
      setState(() {
        print(this._selectedCategory);
      });
    }
  }

  _showPickCategoryDialog(BuildContext context) {
    List<Category> categories = [];
    // List<Category> categories =
    //   BlocProvider.of<CategoriesBloc>(context).state.categories ?? [];
    //categories.removeWhere((element) => (element.title == "Favorites" || element.title == "Memory Verses"));
    showPersistentDialogFromBottom(
      context,
      child: Dialog(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    padding: const EdgeInsets.all(15.0),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    // color: ThemeColors.grey595959,
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
                  )
                  /*  ListTile(
                    
                    title: Text(
                      'CHOOSE CATEGORY',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            // color: ThemeColors.grey595959,
                            fontSize: 20,
                          ),
                    ),
                    trailing: InkWell(
                      child: ImageIcon(
                          AssetImage('assets/images/icons/close.png')),
                      onTap: () => Navigator.pop(context),
                    ),
                  ), */
                  ,
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _upTabController!.index = 0;
                              _selectedIndexValue = 0;
                              _categoryTextEditingController.clear();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'New category',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    // color: ThemeColors.grey595959,
                                    fontSize: 20,
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
                    color: /* (widget.category?.id == 1)
                        ? ThemeColors.greyECECEC
                        : */
                        Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() {
                                _selectedCategory =
                                    Category(id: "1", title: 'Memory Verses');
                                _categoryTextEditingController.text =
                                    'Memory Verses';
                                // _categoryTextEditingController.value = TextEditingValue(
                                //
                                // )
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'Memory Verses',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      // color: ThemeColors.grey595959,
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
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _selectedCategory =
                                  Category(id: "2", title: 'Favorites');
                              _categoryTextEditingController.text = 'Favorites';
                              // _categoryTextEditingController.value = TextEditingValue(
                              //
                              // )
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Favorites',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    // color: ThemeColors.grey595959,
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
                    thickness: 1,
                  ),
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          state.categories?.removeWhere((element) =>
                              element.title?.toLowerCase() == "favorites" ||
                              element.title?.toLowerCase() == "memory verses");
                          categories = state.categories ?? [];
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            separatorBuilder: (context, pos) => Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                color: /* (widget.category?.id ==
                                        categories?[index].id)
                                    ? ThemeColors.greyECECEC
                                    : */
                                    Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            _selectedCategory =
                                                categories[index];
                                            _categoryTextEditingController
                                                    .text =
                                                categories[index].title ?? "";
                                            // _categoryTextEditingController.value = TextEditingValue(
                                            //
                                            // )
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            categories[index].title ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  // color: ThemeColors.grey595959,
                                                  fontSize: 20,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: categories.length ?? 0,
                            shrinkWrap: true,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Column(
                  // shrinkWrap: false,
                  // scrollDirection: Axis.vertical,
                  // padding: EdgeInsets.only(top: 10),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, right: 12, bottom: 12),
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
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 32, right: 32),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: ThemeColors.greyECECEC,
                            borderRadius: BorderRadius.circular(8)),
                        child: TabBar(
                          controller: _upTabController,
                          // isScrollable: true,
                          labelStyle: TextStyle(
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          indicator: PillTabIndicator(),
                          unselectedLabelColor: ThemeColors.grey808082,
                          labelColor: Colors.black,
                          indicatorColor: ThemeColors.grey2E3235,
                          labelPadding: EdgeInsets.symmetric(vertical: 5),

                          indicatorWeight: 0,
                          tabs: <Widget>[
                            const Text("New Category"),
                            const Text("Existing Category"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, top: 28.0, left: 16.0, right: 16.0),
                      child: InkWell(
                        onTap: () => _selectedIndexValue == 0
                            ? null
                            : _showPickCategoryDialog(context),
                        child: ScriptureInputFormField(
                          labelText: _categoryHintText,
                          enabled: _selectedIndexValue == 0,
                          validator: (p0) {
                            if (p0 == "" ||
                               p0 ==
                                    _categoryHintText) {
                              return "";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            if (_selectedIndexValue != 0) {
                              String title = newValue;
                              if (title.isNotEmpty) {
                                _categoryTextEditingController.value =
                                    TextEditingValue(
                                  text: title,
                                  selection: TextSelection.collapsed(
                                      offset: title.length),
                                );
                              }
                            }
                            // _selectedCategory = Category(title: title);
                          },
                          controller: _categoryTextEditingController,
                        ),
                      ),
                    ),
                    Divider(
                      color: ThemeColors.greyB2B2B2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: FocusScope(
                          child: Focus(
                              onFocusChange: (hasFocus) {
                                /*  if(hasFocus)
                                      setState(() {
                                        _verseTextEditingError = false;
                                      }); */
                              },
                              child: ScriptureInputFormField(
                                labelText: 'Type verse address',
                                validator: (p0) {
                            if (p0 == "" ||
                               (BlocProvider.of<VerseBloc>(context).state.verses?.length ?? 0) == 0) {
                              return "";
                            }
                            return null;
                          },
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                onChanged: (newValue) {
                                  context.read<VerseBloc>().add(
                                      VerseEventSearchVerse(query: newValue));
                                  print('newValue');
                                  /*  scriptureController
                                                                                                    .generateScriptures(newValue)
                                                                                                   .then((value) {
                                                                                                  setState(() {
                                                                                                    _scriptureResults = value;
                                                                                                  });
                                                                                                }); */
                                },
                                controller: _verseTextEditingController,
                              ))),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      height: 0.5,
                      color: ThemeColors.greyB2B2B2,
                    ),
                    Expanded(
                      child: Container(
                        color: ThemeColors.greyECECEC,
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<VerseBloc, VerseState>(
                                  builder: (context, state) {
                                    return ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.verses?.length ?? 0,
                                      itemBuilder: (context, position) {
                                        return Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 16.0,
                                            ),
                                            child: ScriptureResultListItem(
                                              bibleVersion: BlocProvider.of<
                                                              BibleVersionBloc>(
                                                          context)
                                                      .state
                                                      .savedVersion ??
                                                  Data.empty(),
                                              scripture:
                                                  state.verses?[position] ??
                                                      Passage.empty(),
                                            ),
                                          ),
                                          actions: <Widget>[],
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                              caption: 'DELETE',
                                              color: ThemeColors.redDD4C4F,
                                              iconWidget: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: ImageIcon(
                                                  AssetImage(
                                                      'assets/images/icons/delete.png'),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () async {
                                                context.read<VerseBloc>()
                                                  ..add(VerseEventDeleteVerse(
                                                      verse: state.verses?[
                                                              position] ??
                                                          Passage.empty()));
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Container(
                                        margin: EdgeInsets.only(
                                            left: 16, top: 4, bottom: 4),
                                        height: 0.5,
                                        color: ThemeColors.greyB2B2B2,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: ThemeColors.greyB2B2B2,
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 4),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              BlocProvider.of<VerseBloc>(context).add(
                                  VerseEventSaveScripture(
                                      verses:
                                          BlocProvider.of<VerseBloc>(context)
                                                  .state
                                                  .verses ??
                                              [],
                                      isNew: _categoryHintText ==
                                          "Type new category name"));
                              Navigator.pop(context);
                            }
                            //context.read<VerseBloc>()..add()
                            /*  bool hasError = false;

      _verseTextEditingError = _scriptures.length <= 0;
      _categoryTextEditingError = _selectedCategory == null ||
          _selectedCategory!.title == null ||
          _selectedCategory!.title!.isEmpty;
      hasError = _verseTextEditingError || _categoryTextEditingError;
      print('Select Cat: $_selectedCategory');

      if (hasError) {
        setState(() {});
        return;
      }

      if (_selectedCategory == null ||
          _selectedCategory!.title == null ||
          _selectedCategory!.title!.isEmpty) {
        hasError = true;
        _categoryTextEditingError = true;
      } else {
        _categoryTextEditingError = false;
      }

      if (_scriptures.length <= 0) {
        hasError = true;
        _verseTextEditingError = true;
      } else {
        _verseTextEditingError = false;
      }

      //In the event that we have any error, go back.
      //I don't know why I wouldn't want to setState() if we don't have an error;
      if (hasError) {
        setState(() {});
        return;
      }

      final List<Scripture> res =
          await Provider.of<ScriptureController>(context, listen: false)
              .addAll(_scriptures, _selectedCategory!);
      if (res.length > 0) {
        
        // Navigator.of(context).pop();
        // if (widget.category != null) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CategoryPage(
              message: 'Saved to ${res.first.categoryName}',
              category: Category(
                id: res.first.category,
                title: res.first.categoryName,
              ),
            ),
          ),
        );
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to save")));
      } */
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            side:
                                BorderSide(width: 2, color: Color(0xFFA7B0B3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 18),
                            child: Text(
                              'Save',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: ThemeColors.saveText(context),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SFUIText',
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
 */