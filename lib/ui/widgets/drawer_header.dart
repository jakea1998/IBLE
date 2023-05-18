
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/pages/settings_page.dart';
import 'package:ible/ui/pages/sign_in.dart';
import 'package:ible/ui/widgets/dcupertino_overflow_menu.widget.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              child: Text(
                'IBLE',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Color(0xFF595D61),
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DCenteredOverflowMenu(
                backgroundColor: Colors.white,
                children: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/icons/mail.png',
                              height: 24,
                              width: 24,
                              color: ThemeColors.grey808082,
                            ),
                            Positioned(
                              right: -12,
                              top: -8,
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: ThemeColors.redFE3D2F,
                                  ),
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: ThemeColors.greyF7F7F7,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Inbox',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/search (1).png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Library',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          SlideFromRightPageRoute(widget: SettingsPage()));
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/settings (1).png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Settings',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          SlideFromRightPageRoute(widget: LoginPage()));
                      // openFromDhaza(context, category);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'assets/images/icons/logout.png',
                          height: 24,
                          width: 24,
                          color: ThemeColors.grey808082,
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Text(
                          'Sign In',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    color: ThemeColors.grey2E3235,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // IconButton(
            //     padding: EdgeInsets.symmetric(horizontal: 12),
            //     constraints: BoxConstraints(),
            //     icon: Image.asset(
            //       'assets/images/icons/more.png',
            //       height: 24,
            //       width: 24,
            //     ),
            //     onPressed: () {}),
          ),
          Positioned(
            right: 20,
            top: -12,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ThemeColors.redFE3D2F,
                ),
                height: 24,
                width: 24,
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: ThemeColors.greyF7F7F7,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          )
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: IconButton(
          //       padding: EdgeInsets.symmetric(horizontal: 12),
          //       constraints: BoxConstraints(),
          //       icon: Image.asset(
          //         'assets/images/icons/more.png',
          //         height: 24,
          //         width: 24,
          //       ),
          //       onPressed: () {}),
          // ),
        ],
      ),
    );
  }
}