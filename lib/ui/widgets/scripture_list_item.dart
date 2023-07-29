import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/selected_item/selected_item_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';

import 'package:ible/theme.dart';
import 'package:ible/ui/pages/category_page.dart';
import 'package:ible/ui/widgets/menu.dart';

import 'package:ible/ui/widgets/tab_indicator.dart';

import 'package:provider/provider.dart';

import 'slide_from_right_page_route.widget.dart';

class ScriptureListItem extends StatelessWidget {
  final Passage scripture;
  final Data bibleVersion;
  final List<Category> sharedCategories;
  final List<Category> sharedSubCategories;
  const ScriptureListItem({Key? key,required this.bibleVersion, required this.sharedCategories,required this.sharedSubCategories,required this.scripture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegExp numRegex = RegExp(r'(\d)');
    String? numPart = '';
    String? textPart;
    if (numRegex.hasMatch(scripture.bookId ?? '')) {
      numPart = numRegex.firstMatch(scripture.bookId ?? '')!.group(0);
      //textPart = scripture.bookId!.substring(scripture.bookId!.indexOf(' '));
    } else
      textPart = scripture.bookId;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              
              
              Text(
                ' ${scripture.reference}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () => showChangeVersionPicker(context, scripture),
                  child: Text(
                    bibleVersion.abbreviation?.toString().toUpperCase() ?? "",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ThemeColors.blue4681D2,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
            ],
          ),

          HtmlWidget(scripture.content ?? "")

          // TODO: Fix the context menu to not interfere with slide action;
          // CupertinoContextMenu(
          //   child: Text(
          //     note.text,
          //     textAlign: TextAlign.start,
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          //   previewBuilder: (context, Animation animation, Widget child) {
          //     return ClipRRect(
          //       borderRadius: BorderRadius.circular(16.0 * animation.value),
          //       child: Container(
          //         padding: EdgeInsets.all(16),
          //         child: child,
          //         color: Theme.of(context).backgroundColor,
          //       ),
          //     );
          //   },
          //   actions: <Widget>[
          //     CupertinoContextMenuAction(
          //       child: const Text('Close'),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //     // CupertinoContextMenuAction(
          //     //   child: const Text('Action two'),
          //     //   onPressed: () {
          //     //     Navigator.pop(context);
          //     //   },
          //     // ),
          //   ],
          // ),
          // FutureBuilder(builder: (context, snapshot){
          //   if(!snapshot.hasData) return Container();
          //   final crossRefs
          // }),,
,
          if (sharedCategories.length > 0  ||sharedSubCategories.length >0)
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  ...sharedCategories.map((category) => InkWell(
                    onTap: () { 
                    BlocProvider.of<SelectedItemBloc>(context).add(
                          SelectedItemEventSelectItem(item: category));
                      Navigator.pushReplacement(
                      context,
                      SlideFromRightPageRoute(
                        widget: CategoryPage(
                          category: category,
                        ),
                    ),
                    );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16, top: 8),
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ThemeColors.pillBackground(context),
                      ),
                      child: Text(
                        category.title!,
                        style:
                        Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ThemeColors.pill(context),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
  
                  // FutureBuilder<Category>(
                  //   future:
                  //       Provider.of<CategoryController>(context, listen: false)
                  //           .get(scripture.cross),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData)
                  //       return InkWell(
                  //         onTap: () => Navigator.pushReplacement(
                  //           context,
                  //           SlideFromRightPageRoute(
                  //             widget: CategoryPage(
                  //               category: snapshot.data,
                  //             ),
                  //           ),
                  //         ),
                  //         child: Container(
                  //           margin: EdgeInsets.only(right: 16, top: 8),
                  //           padding:
                  //               EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(16),
                  //             color: ThemeColors.pillBackground(context),
                  //           ),
                  //           child: Text(
                  //             snapshot.data.title,
                  //             style:
                  //                 Theme.of(context).textTheme.bodyText1.copyWith(
                  //                       color: ThemeColors.pill(context),
                  //                       fontSize: 17,
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //           ),
                  //         ),
                  //       );
                  //     return Container();
                  //   },
                  // )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

///Show the version picker dialog
showChangeVersionPicker(BuildContext context, Passage? scripture,
    [showTabs = true]) {
  /* showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return Material(
        child: Container(
          height: 275,
          color: Colors.white,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: CupertinoButton(
                        child: Text(
                          'Done',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.only(right: 16),
                      ),
                    ),
                    if (!showTabs) Spacer(),
                    if (showTabs)
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: ThemeColors.greyECECEC,
                              borderRadius: BorderRadius.circular(8)),
                          child: TabBar(
                            // isScrollable: true,
                            labelStyle: TextStyle(
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: ThemeColors.grey2E3235,
                              height: 1.5
                            ),
                            indicator: PillTabIndicator(indicatorHeight: 24),
                            unselectedLabelColor: ThemeColors.grey808082,
                            indicatorColor: ThemeColors.grey2E3235,
                            labelPadding: EdgeInsets.symmetric(vertical: 2),
                            indicatorWeight: 4,
                            tabs: <Widget>[
                              const Text("Change one"),
                              const Text("Change all"),
                            ],
                          ),
                        ),
                      ),
                    CupertinoButton(
                      child: Text(
                        'Done',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontFamily: 'SFUIText',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.blue007AFF,
                            ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.only(right: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<VersionController>(
                      builder: (context, controller, child) {
                    if (controller.downloadedVersions == null)
                      return CupertinoActivityIndicator();

                    if (controller.downloadedVersions!.isEmpty)
                      return Text('Go to settings to download more versions.');
                    return CupertinoPicker(
                      backgroundColor: Colors.white,
                      onSelectedItemChanged: (value) async {
                        final categoryController =
                            Provider.of<CategoryController>(
                          context,
                          listen: false,
                        );
                        final scriptureController =
                            Provider.of<ScriptureController>(
                          context,
                          listen: false,
                        );
                        final all = DefaultTabController.of(context)!.index == 1;
                        await scriptureController.updateVersion(
                          scripture!,
                          controller.downloadedVersions![value],
                          all,
                        );
                        await Future.delayed(Duration(milliseconds: 300));
                        categoryController.refresh();
                      },
                      itemExtent: 32.0,
                      children: controller.downloadedVersions!
                          .map((v) => Text(v.version!))
                          .toList(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ); */
}
