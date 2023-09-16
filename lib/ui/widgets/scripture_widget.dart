import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/pages/category_page.dart';
import 'package:ible/ui/pages/scripture_page.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:ible/ui/widgets/scripture_list_item.dart';
import 'package:ible/utils/delete_scripture_dialog.dart';
import 'package:ible/utils/pick_cat_dialog.dart';

class ScriptureWidget extends StatefulWidget {
  final Category selectedCategory;
  final int index;
  final SlidableController slidableController;
  final VoidCallback onMoveTapped;
  final List<Category> sharedCats;
  final List<Category> sharedSubCats;

  const ScriptureWidget(
      {Key? key,
      required this.selectedCategory,
      required this.index,
      required this.slidableController,
      required this.onMoveTapped,
      required this.sharedCats,
      required this.sharedSubCats})
      : super(key: key);

  @override
  State<ScriptureWidget> createState() => _ScriptureWidgetState();
}

class _ScriptureWidgetState extends State<ScriptureWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScripturePage(
                      bibleVersion: widget.selectedCategory
                              .verses?[widget.index].bibleVersion ??
                          Data.empty(),
                      passage: widget.selectedCategory.verses?[widget.index] ??
                          Passage.empty(),
                    )));
      },
      child: Container(
        color: Colors.transparent,
        child: Slidable(
          endActionPane:
              ActionPane(extentRatio: 0.65, motion: ScrollMotion(), children: [
            SlidableAction(
              backgroundColor: Colors.grey[900] ?? Colors.grey,
              label: 'MOVE TO',
              foregroundColor: Colors.white,
              padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
              icon: Icons.arrow_right,
              onPressed: (context) {
                widget.onMoveTapped();
              },
            ),
            SlidableAction(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              icon: Icons.pin,
              label: 'PIN TOP',
              padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
              onPressed: (context) {
                if (widget.selectedCategory.pinned?.id.toString() ==
                    widget.selectedCategory.verses?[widget.index].id
                        .toString()) {
                  BlocProvider.of<CategoriesBloc>(context)
                      .add(CategoriesEventPinOrUnpinVerse(pinOrUnpin: false));
                } else {
                  BlocProvider.of<CategoriesBloc>(context).add(
                      CategoriesEventPinOrUnpinVerse(
                          pinOrUnpin: true,
                          verse:
                              widget.selectedCategory.verses?[widget.index] ??
                                  Passage.empty()));
                }
                /*  Provider.of<CategoryController>(context, listen: false)
                          .pinScripture(category!, scripture.id); */
              },
            ),
            SlidableAction(
              label: 'DELETE',
              backgroundColor: ThemeColors.redDD4C4F,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.only(bottom: 8.0, right: 4, left: 4),
              icon: Icons.delete,
              onPressed: (context) async {
                deleteScriptureDialog(
                    context,
                    widget.selectedCategory.verses?[widget.index] ??
                        Passage.empty());
              },
            ),
          ]),
          child: Container(
            padding:
                EdgeInsets.only(left: 16.0, top: 16, bottom: 16, right: 16),
            color: Colors.transparent,
            child: ScriptureListItem(
              sharedCategories: widget.sharedCats,
              sharedSubCategories: widget.sharedSubCats,
              bibleVersion:
                  widget.selectedCategory.verses?[widget.index].bibleVersion ??
                      Data.empty(),
              scripture: widget.selectedCategory.verses?[widget.index] ??
                  Passage.empty(),
            ),
          ),
        ),
      ),
    );
  }
}
