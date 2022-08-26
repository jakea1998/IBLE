import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

import 'package:ible/theme.dart';

class ScriptureResultListItem extends StatelessWidget {
  final Passage scripture;
  final Data bibleVersion;
  final Function(Passage)? changeVersion;

  const ScriptureResultListItem(
      {Key? key, required this.scripture, required this.bibleVersion, this.changeVersion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegExp numRegex = RegExp(r'(\d)');
    String? numPart = '';
    String? textPart;
    if (numRegex.hasMatch(scripture.bookId ?? '')) {
      numPart = numRegex.firstMatch(scripture.bookId ?? '')!.group(0);
      textPart = scripture.bookId!.substring(scripture.bookId!.indexOf(' '));
    } else
      textPart = scripture.bookId;
    return Container(
      color: Colors.transparent, //Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                ' ${scripture.reference}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () => changeVersion!(scripture),
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
          Html(data: scripture.content)
          /* Text(
            '${scripture}',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1,
          ), */
        ],
      ),
    );
  }
}
