import 'package:flutter/material.dart';

import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/menu.dart';

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
  State<SlidingScaffold> createState() => _SlidingScaffoldState();
}

class _SlidingScaffoldState extends State<SlidingScaffold> {
  final _key = GlobalKey<SliderDrawerState>();
  void open() {
    _key.currentState!.openSlider();
  }

  void close() {
    _key.currentState!.closeSlider();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /*  _key.currentState?.animationController.addListener(() {
      if (_key.currentState?.isDrawerOpen ?? false) {
        if(widget.onWillOpen != null) {
          widget.onWillOpen!();
        }
      }
    }); */
  }
  /* Theme(
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
                    ), */

  @override
  Widget build(BuildContext context) {
    return Theme(
     
                      data: Theme.of(context).copyWith(
                        appBarTheme: AppBarTheme(
                            color: widget.appBarColor ??
                                Theme.of(context).backgroundColor),),
      child: Scaffold(
        body: SliderDrawer(
          animationDuration: 100,
          key: _key,
          appBar: SliderAppBar(
              appBarColor:
                  widget.appBarColor ?? Theme.of(context).backgroundColor,
              appBarHeight: 100,
              drawerIcon: Stack(
                children: [
                  
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: ImageIcon(
                        AssetImage('assets/images/icons/menu.png'),
                        color: ThemeColors.appBarIconColor,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap:(){
                        if (_key.currentState?.isDrawerOpen ?? false) {
                          _key.currentState?.closeSlider();
                        } else {
                          _key.currentState?.openSlider();
                        }
                      },
                      
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
              drawerIconSize: 90,
              trailing:
                  Row(children: widget.actions != null ? widget.actions! : []),
              title: widget.title),
          slider: Menu(),
          child: Stack(
            children: [
              Column(
                children: [
                  if (widget.divider)
                    Container(
                      color: Theme.of(context).dividerColor,
                      height: 1,
                    ),
                  Expanded(child: widget.body),
                  
                ],
              ),
              widget.floatingActionButton != null ?Positioned.fill( child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:60.0),
                  child: widget.floatingActionButton ?? Container(),
                ))) : Container(),
            ],
          ),
        ),
        //floatingActionButton:  widget.floatingActionButton,
        
      ),
    );
  }
}
