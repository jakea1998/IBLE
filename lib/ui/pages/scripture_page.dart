import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';

class ScripturePage extends StatefulWidget {
  final Passage passage;
  final Data bibleVersion;
  const ScripturePage(
      {Key? key, required this.passage, required this.bibleVersion})
      : super(key: key);

  @override
  State<ScripturePage> createState() => _ScripturePageState();
}

class _ScripturePageState extends State<ScripturePage> {
  @override
  Widget build(BuildContext context) {
    final RegExp numRegex = RegExp(r'(\d)');
    String? numPart = '';
    String? textPart;
    if (numRegex.hasMatch(widget.passage.bookId ?? '')) {
      numPart = numRegex.firstMatch(widget.passage.bookId ?? '')!.group(0);
      textPart =
          widget.passage.bookId!.substring(widget.passage.bookId!.indexOf(' '));
    } else
      textPart = widget.passage.bookId;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: DCupertinoOverflowMenu(
                  children: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        /*  Navigator.pop(context);
                    final scriptures = Provider.of<CategoryController>(
                      context,
                      listen: false,
                    ).notes!;
                    var list = '';
                    scriptures.forEach((scripture) {
                      list += '\n\n${scripture.print}';
                    });
                    Clipboard.setData(ClipboardData(text: list.trim())); */
                      },
                      child: Text('Copy Scripture'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        /*  Navigator.pop(context);
                          final del =
                              await deleteCategoryDialog(context, category);

                          Navigator.pushReplacement(
                              context,
                              SlideFromRightPageRoute(
                                  widget: CategoryPage(
                                category: Category(id: "2", title: 'Favs'),
                              ))); */
                      },
                      child: Text('Delete Scripture'),
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
            ],
            leading: BackButton(
              color: Colors.grey[400],
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical:10,horizontal:20),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom:14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*   Text(
                    '$numPart',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppStyles.textColor(context),
                        fontSize: 20),
                  ),
                  Text(
                    '$textPart',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w600,
                        color: AppStyles.textColor(context),
                        fontSize: 20),
                  ), */
                    Text(
                      ' ${widget.passage.reference}',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          widget.bibleVersion.abbreviation
                                  ?.toString()
                                  .toUpperCase() ??
                              "",
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
              ),
              HtmlWidget(widget.passage.content ?? "")
            ]),
          ),
        ));
  }
}
