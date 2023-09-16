import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ible/blocs/notes/notes_bloc.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/note_model.dart';
import 'package:ible/models/scripture_model.dart';

import 'package:ible/theme.dart';
import 'package:ible/ui/pages/category_page.dart';
import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';
import 'package:ible/ui/widgets/dtoggle_style_button.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/ui/widgets/sliding_scaffold_new.dart';

class NotePage extends StatefulWidget {
  final NoteModel? note;
  final List<Scripture>? scriptures;

  const NotePage({Key? key, this.note, this.scriptures = const []})
      : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _noteTitleEditorController = TextEditingController();

  /// Show or hide the editor toolbar
  ///
  /// Variable is dependent on the status of [_quillFocusNode]
  bool showToolbar = false;

  quill.QuillController _controller = quill.QuillController.basic();
  ScrollController _scrollController = ScrollController();

  //Use this focus node for some reason.
  final _quillFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    String text = widget.note?.description ?? '';
    _noteTitleEditorController.text = widget.note?.title ?? "";
    if (text.trim().isNotEmpty) {
      var myJSON = jsonDecode(text);
      final doc = quill.Document.fromJson(myJSON);
      if (widget.scriptures!.isNotEmpty) {
        var scrrs = '';
        widget.scriptures!.forEach((scripture) {
          scrrs += '\n\n${scripture.print()}';
          doc.compose(quill.Delta()..insert('\n\n${scripture.print()}'),
              quill.ChangeSource.LOCAL);
        });
      }
      _controller = quill.QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
    } else {
      final doc = quill.Document();
      if (widget.scriptures!.isNotEmpty) {
        widget.scriptures!.forEach((scripture) {
          doc.compose(quill.Delta()..insert('${scripture.print()}'),
              quill.ChangeSource.LOCAL);
        });
      }
      _controller = quill.QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
    }
    _noteTitleEditorController.addListener(() {
      NoteModel note = widget.note ?? NoteModel();

      note.title = _noteTitleEditorController.text;

      // BlocProvider.of<NotesBloc>(context).add(NotesEventSaveNote(note: note));
    });
    _controller.changes.listen((event) {
      NoteModel note = widget.note ?? NoteModel();

      note.description = jsonEncode(_controller.document.toDelta().toJson());

      //  BlocProvider.of<NotesBloc>(context).add(NotesEventSaveNote(note: note));

      _getVerse(_controller.plainTextEditingValue);
    });

    // TODO: Add this logic
    var title = widget.note?.title ?? '';
    _noteTitleEditorController.text = title;

    ///Because the node won't update setState() automatically
    _quillFocusNode.addListener(() {
      if (_quillFocusNode.hasFocus) {
        print('Got focus');
        showToolbar = true;
      } else {
        print('Lost focus');
        showToolbar = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       /*  var category = widget.category!;
        category.description = jsonEncode(
          _controller.document.toDelta().toJson(),
        ); */
        //category.updated = DateTime.now();
        NoteModel note = widget.note ?? NoteModel();

        note.description = jsonEncode(_controller.document.toDelta().toJson());
        note.title = _noteTitleEditorController.text;

        BlocProvider.of<NotesBloc>(context).add(NotesEventSaveNote(note: note));
        //category.noteTitle = _noteTitleEditorController.text;

        //print(category.toMap());

        //category = (await controller.update(category))!;
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );

        Navigator.pop(context);
        Navigator.pop(context, true);
        return false;
      },
    
      child: SlidingScaffold(
        appBarColor: Colors.white,
        isOpen: false,
        title: Text(
          'Note',
          style: AppStyles.titleStyle(context),
        ),
        actions: [
          DCupertinoOverflowMenu(
            children: [
              // CupertinoActionSheetAction(
              //   onPressed: () async {
              //     Navigator.pop(context);
              //     var category = widget.category;
              //     category.description = _textEditorController.text;
              //     showDialog(
              //       context: context,
              //       child: Dialog(
              //         child: Center(
              //           child: CupertinoActivityIndicator(),
              //         ),
              //       ),
              //     );
              //     category = await controller.update(category);
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         SlideFromRightPageRoute(
              //             widget: CategoryPage(
              //           category: category,
              //         )));
              //   },
              //   child: Text('Save'),
              // ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  Clipboard.setData(
                    ClipboardData(text:  ""),
                  );
                },
                child: Text('Copy Note'),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                  final delete = await showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        title: Container(
                          child: Text(
                            'Delete Note?',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: ThemeColors.grey808082,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        message: Container(
                          child: Text(
                            'Deleting this note will remove it from this category permanently.',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: ThemeColors.grey808082,
                                    ),
                          ),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              

                              BlocProvider.of<NotesBloc>(context).add(
                                  NotesEventDeleteNote(
                                      note: widget.note ??
                                          NoteModel.empty()));
                            /*   Navigator.pop(context);
                              Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: CategoryPage(
                                  message: 'Note deleted',
                                  category: category,
                                )),
                              ); */
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
                },
                child: Text('Delete Note'),
              ),
            ],
          ),
          IconButton(
              icon: ImageIcon(AssetImage('assets/images/icons/share.png')),
              onPressed: () {})
        ],
        body: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 16, top: 16),
                        child: Text(
                          "",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 26, color: ThemeColors.grey414747),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16, left: 16, top: 12),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Title',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: ThemeColors.greyABABAB,
                                    fontSize: 24),
                          ),
                          maxLines: null,
                          controller: _noteTitleEditorController,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: ThemeColors.grey2E3235,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Builder(builder: (context) {
                          final updated =
                              (widget.category?.updated ?? DateTime.now());
                          return Text(
                            '${updated.month}/${updated.day}/${updated.year}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: ThemeColors.grey595959,
                                    fontSize: 16),
                          );
                        }),
                      ), */
                      SizedBox(height: 10),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: quill.QuillEditor(
                            focusNode: _quillFocusNode,
                            controller: _controller,
                            readOnly: false,
                            scrollable: true,
                            scrollController: ScrollController(),
                            autoFocus: false,
                            placeholder: 'Add content',
                            expands: false,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _quillFocusNode.hasFocus,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    // tooltip: 'Undo',
                    child: Image.asset(
                      'assets/images/icons/undo.png',
                      height: 36,
                      width: 36,
                    ),
                    onTap: () async {
                      if (_controller.hasUndo) {
                        _controller.undo();
                      }
                    },
                  ),
                  InkWell(
                    // tooltip: 'Redo',
                    child: Image.asset(
                      'assets/images/icons/redo.png',
                      height: 36,
                      width: 36,
                    ),
                    onTap: () async {
                      if (_controller.hasRedo) {
                        _controller.redo();
                      }
                    },
                  ),
                  DToggleStyleButton(
                    iconWidget: Image.asset(
                      'assets/images/icons/bold.png',
                      height: 36,
                    ),
                    controller: _controller,
                    attribute: quill.Attribute.bold,
                  ),
                  DToggleStyleButton(
                    iconWidget: Image.asset(
                      'assets/images/icons/italic.png',
                      height: 36,
                    ),
                    controller: _controller,
                    attribute: quill.Attribute.italic,
                  ),
                  DToggleStyleButton(
                    iconWidget: Image.asset(
                      'assets/images/icons/underline.png',
                      height: 36,
                    ),
                    controller: _controller,
                    attribute: quill.Attribute.underline,
                  ),
                  InkWell(
                    child: Image.asset(
                      'assets/images/icons/done.png',
                      height: 24,
                    ),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  DToggleStyleButton(
                    iconWidget: Image.asset(
                      'assets/images/icons/bullet_list.png',
                      height: 36,
                    ),
                    controller: _controller,
                    attribute: quill.Attribute.ul,
                  ),
                  DToggleStyleButton(
                    iconWidget: Image.asset(
                      'assets/images/icons/list.png',
                      height: 36,
                    ),
                    controller: _controller,
                    attribute: quill.Attribute.ol,
                  ),
                  // InkWell(
                  //   child: Image.asset('assets/images/icon', height: 36,),
                  //   onTap: () {
                  //     keyEditor.currentState!.javascriptExecutor
                  //         .insertNumberedList();
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _editorKeyListener(RawKeyEvent event) {
  print('Event: $event');

  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
    //final lastText = _controller.document;
    //print(_controller.document);
  }
}

void _getVerse(TextEditingValue value) async {
  String pattern = r'^\d+(?:\.\d+)?$';
  RegExp regex = new RegExp(r'John 3 vs 16 *:*\n{2,}$');
  RegExp singleVerseRegexp = new RegExp(
      r'(\d ?\w+|\w+) ?(\d+) ?(?:: ?| ?vs) ?(?!\d+ ?- ?\d+)(\d+) *:*\n{2,}$');
  RegExp multiVerseRegexp = new RegExp(
      r'(\d ?\w+|\w+) ?(\d+) ?(?:: ?| ?vs) ?(\d+ ?- ?\d+) *:*\n{2,}$');
  String? verse;
  if (multiVerseRegexp.hasMatch(value.text)) {
    verse = multiVerseRegexp.stringMatch(value.text);
    print('Has MultiVerse Match: $verse');
  } else if (singleVerseRegexp.hasMatch(value.text)) {
    verse = singleVerseRegexp.stringMatch(value.text);
    print('Has Single Match $verse');
  }

  if (verse != null) {
    print('Verse: $verse');
    /* final scriptures =
          await Provider.of<ScriptureController>(context, listen: false)
              .generateScriptures(verse); */
    //print('Scripture: $scriptures');
    //todo: null safety
    //  final scripture = scriptures.first;
    //_controller.document.compose(
    /*     Delta()
            ..retain(_controller.document.length - (1 + verse.length))
            ..delete(verse.length)
            ..insert('\n'),
          ChangeSource.LOCAL);
      _controller.updateSelection(
        TextSelection.collapsed(offset: _controller.document.length - 1),
        ChangeSource.LOCAL,
      ); */
  }
}

// final DateFormat formatter = DateFormat('yyyy-MM-dd');
