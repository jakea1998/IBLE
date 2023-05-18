/* import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ible/theme.dart';
//import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';
import 'package:ible/ui/widgets/ible_drawer.widget.dart';
import 'package:ible/ui/widgets/menu.dart';
import 'package:provider/provider.dart';

import 'ible_drawer.widget.dart';

class SlidingScaffold extends StatefulWidget {
  final Widget body;
  final Widget title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool divider;
  final Color? appBarColor;
  final Function? onWillOpen;

  const SlidingScaffold({
    Key? key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
    this.divider = false,
    this.appBarColor,
    this.onWillOpen,
  }) : super(key: key);

  @override
  _SlidingScaffoldState createState() => _SlidingScaffoldState();
}

class _SlidingScaffoldState extends State<SlidingScaffold>
    with TickerProviderStateMixin {
  bool isCollapsed = true;
  double? screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 250);
  final Duration _menuDuration = const Duration(milliseconds: 250);
  late AnimationController _controller;
  late AnimationController _menuController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  Animation<Offset>? _slideAnimation;
  late Animation<Offset> _menuSlideAnimation;
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration);
    _menuController = AnimationController(vsync: this, duration: _menuDuration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 1, end: 1).animate(_menuController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _menuSlideAnimation =
        Tween<Offset>(begin: Offset(-0.2, 0), end: Offset(0, 0))
            .animate(_menuController);

    _menuController.addListener(() {
      opacity = _menuController.value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          int sensitivity = 4;
          if (details.delta.dx > sensitivity) {
            setState(() {
              _controller.forward();
              _menuController.forward();
              isCollapsed = false;
            });
          } else if (details.delta.dx < -sensitivity) {
            setState(() {
              _controller.reverse();
              _menuController.reverse();
              isCollapsed = true;
            });
          }
        },
        child: Stack(
          children: <Widget>[
           
               menu(context),
             
            IgnorePointer(
              child: Opacity(
                opacity: 1 - opacity,
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            dashboard(context),
            SizedBox(
              width: screenWidth,
            ),
          ],
        ),
      ),
      floatingActionButton: isCollapsed ? widget.floatingActionButton : null,
    );
  }

  Widget menu(context) {
    return GestureDetector(
      // onHorizontalDragStart: (details){
      //   print('Drag Started: $details');
      // },
      // onHorizontalDragUpdate: (details){
      //   print(details);
      // },
      // onHorizontalDragEnd: (details){
      //   print('Drag ended: $details');
      // },
      // onHorizontalDragCancel: (){
      //   print('Drag canceled: ');
      // },
      child: SlideTransition(
        position: _menuSlideAnimation,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 2 / 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Menu(),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 2 / 3 * screenWidth!,
      right: isCollapsed ? 0 : -2 / 3 * screenWidth!,
      curve: Curves.easeInOutCubic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isCollapsed
            ? null
            : () {
                setState(() {
                  _controller.reverse();
                  _menuController.reverse();
                  isCollapsed = !isCollapsed;
                });
              },
        child: IgnorePointer(
          ignoring: !isCollapsed,
          child: Material(
            animationDuration: duration,
            elevation: 8,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: SafeArea(
              bottom: false,
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(
                        appBarTheme: AppBarTheme(
                            color: widget.appBarColor ??
                                Theme.of(context).backgroundColor),
                      ),
                      child: AppBar(
                        backgroundColor: null,
                        elevation: 0,
                        centerTitle: true,
                        leading: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ImageIcon(
                              AssetImage('assets/images/icons/menu.png'),
                              color: ThemeColors.appBarIconColor,
                              size: Theme.of(context).iconTheme.size,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                //notify who wants that we are going to open
                                if (widget.onWillOpen != null) {
                                  if (!widget.onWillOpen!()) return;
                                }
                                // _controller.animateTo(0.0);
                                // _menuController.animateTo(0.0);
                                _controller.forward();
                                _menuController.forward();
                              } else {
                                _controller.reverse();
                                _menuController.reverse();
                              }

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        title: widget.title,
                        actions: widget.actions,
                      ),
                    ),
                    if (widget.divider)
                      Container(
                        color: Theme.of(context).dividerColor,
                        height: 1,
                      ),
                    Expanded(child: widget.body ?? Container()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 */