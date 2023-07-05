import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/blocs/verse/verse_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/add_scripture_widgets/no_matches.dart';
import 'package:ible/ui/widgets/scripture_result_list_item.dart';

class VerseDisplay extends StatelessWidget {
  const VerseDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ThemeColors.greyECECEC,
        child: BlocBuilder<VerseBloc, VerseState>(
          builder: (context, state) {
            print(state.verses?.length);
            if (state.verseStatus == VerseStatus.no_matches_error || state.verses == null || (state.verses?.isEmpty ?? true)) {
              return NoMatches();
            } else
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.verses?.length ?? 0,
                itemBuilder: (context, position) {
                  print(state.verses?[position].content);
                  return Slidable(
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ScriptureResultListItem(
                          bibleVersion:
                              BlocProvider.of<BibleVersionBloc>(context)
                                      .state
                                      .savedVersion ??
                                  Data.empty(),
                          scripture: state.verses?[position] ?? Passage.empty(),
                        ),
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            label: 'DELETE',
                            backgroundColor: ThemeColors.redDD4C4F,
                            padding: const EdgeInsets.only(bottom: 8.0),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            onPressed: (context) async {
                              context.read<VerseBloc>()
                                ..add(VerseEventDeleteVerse(
                                    verse: state.verses?[position] ??
                                        Passage.empty()));
                            },
                          ),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(left: 16, top: 4, bottom: 4),
                  height: 0.5,
                  color: ThemeColors.greyB2B2B2,
                ),
              );
          },
        ),
      ),
    );
  }
}
