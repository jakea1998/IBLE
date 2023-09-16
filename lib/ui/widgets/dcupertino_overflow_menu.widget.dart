import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ible/theme.dart';


class DCupertinoOverflowMenu extends StatefulWidget {
  final List<Widget> children;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color iconColor;
  final ValueChanged<int>? onChange;

  const DCupertinoOverflowMenu({
    Key? key,
    required this.children,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor = Colors.black,
    this.onChange,
  })  : assert(children != null),
        super(key: key);

  @override
  _DCupertinoOverflowMenuState createState() => _DCupertinoOverflowMenuState();
}

class _DCupertinoOverflowMenuState extends State<DCupertinoOverflowMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  BorderRadius? _borderRadius;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(16);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key!.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () {
        findButton();
        _showDialog();
      },
      child: ImageIcon(
        AssetImage('assets/images/icons/more.png'),
        color: ThemeColors.appBarIconColor,
      ),
    );
  }

  _showDialog() {
    showDialog(
      barrierColor: Colors.black38,
      context: context,
      builder: (BuildContext cxt) {
        return _buildChild();
      },
    );
  }

  _buildChild() {
    List<Widget> _children = [];
    for (int i = 0; i < widget.children.length; i++) {
      _children.add(widget.children[i]);
      if (i + 1 < widget.children.length)
        _children.add(ActionSheetItemDivider());
    }

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width -
              buttonPosition.dx -
              buttonSize.width * 1.5,
          top: Platform.isAndroid ? buttonPosition.dy + 12 : buttonPosition.dy,
          left: 56,
        ),
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            /* Positioned(
              //alignment: Alignment.topCenter,
              right: 6,
              top: 0,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 32,
                    height: 32,
                    color: widget.backgroundColor ??
                        Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ), */
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Container(
                // padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: _borderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                        SizedBox(
                          height: 1,
                        ),
                      ] +
                      _children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DCenteredOverflowMenu extends StatefulWidget {
  final List<Widget> children;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color iconColor;
  final ValueChanged<int>? onChange;

  const DCenteredOverflowMenu({
    Key? key,
    required this.children,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor = Colors.black,
    this.onChange,
  })  : assert(children != null),
        super(key: key);

  @override
  _DCenteredOverflowMenuState createState() => _DCenteredOverflowMenuState();
}

class _DCenteredOverflowMenuState extends State<DCenteredOverflowMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  Size? buttonSize;
  BorderRadius? _borderRadius;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(16);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key!.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () {
        findButton();
        _showDialog();
      },
      child: ImageIcon(
        AssetImage('assets/images/icons/more.png'),
        color: ThemeColors.appBarIconColor,
      ),
    );
  }

  _showDialog() {
    showDialog(
      barrierColor: Colors.black38,
      context: context,
      builder: (BuildContext cxt) {
        return _buildChild();
      },
    );
  }

  _buildChild() {
    List<Widget> _children = [];
    for (int i = 0; i < widget.children.length; i++) {
      _children.add(widget.children[i]);
      if (i + 1 < widget.children.length)
        _children.add(Container(
          height: 0.5,
          color: ThemeColors.grey808082,
        ));
    }

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.only(
          right: 56,
          top: Platform.isAndroid ? buttonPosition.dy + 12 : buttonPosition.dy,
          left: 56,
        ),
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Container(
                // padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ??
                      Theme.of(context).backgroundColor,
                  borderRadius: _borderRadius,
                ),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 23,
                        color: ThemeColors.grey2E3235,
                        fontWeight: FontWeight.normal,
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                          SizedBox(
                            height: 1,
                          ),
                        ] +
                        _children,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionSheetItemDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      // color: Theme.of(context).dividerColor,
      thickness: 0.5,
    );
  }
}
