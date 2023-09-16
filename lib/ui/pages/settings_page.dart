import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/ui/pages/languages_page.dart';
import 'package:ible/ui/pages/versions_page.dart';
import 'package:ible/ui/widgets/pill.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';
import 'package:ible/ui/widgets/sliding_scaffold.widget.dart';
import 'package:ible/ui/widgets/sliding_scaffold_new.dart';

import '../../theme.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin{
  late SlidableController slidableController;
  @override
  void initState() {
    // TODO: implement initState
    slidableController =  SlidableController(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SlidingScaffold(
      isOpen: false,
      title: Text('Settings',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
      appBarColor: Colors.white,
      onWillOpen: () {
        /* f (slidableController.activeState != null) {
          slidableController.activeState?.close();
          return false;
        } else
          return true; */
      },
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Israel Ita',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      '+Saintcali289',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: ThemeColors.grey595959,
                            fontSize: 20,
                          ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),

            SizedBox(height: 44),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                /*   Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                              widget: PersonalInfoPage(),
                            ),
                          ); */
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Personal Info'),
                    Spacer(),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),

            ///

            ///
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'General',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Themes'),
                    Spacer(),
                    Pill(text: 'Pistachio'),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    SlideFromRightPageRoute(
                      widget: VersionsPage(),
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Versions',
                      overflow: TextOverflow.clip,
                    )),
                    BlocBuilder<BibleVersionBloc, BibleVersionState>(
                      builder: (context, state) {
                        return Pill(text: state.savedVersion?.abbreviation?.toUpperCase() ?? "");
                      },
                    ),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),

            ///

            ///
            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlideFromRightPageRoute(
                    widget: LanguagesPage(),
                  ),
                );
              },
              /* Navigator.push(
                            context,
                            /* SlideFromRightPageRoute(
                              widget: LanguagePage(),
                            ), */
                          ), */
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('App Interface'),
                    Spacer(),
                    Pill(text: 'English'),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),

            ///

            ///

            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Resource',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Library'),
                    Spacer(),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),

            ///
            SizedBox(height: 24),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: VersionPage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.grey2E3235,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Face ID'),
                    Spacer(),
                    CupertinoSwitch(
                      value: false,
                      onChanged: (val) {},
                      trackColor: ThemeColors.greyC2C2C2,
                      activeColor: ThemeColors.blue007AFF,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Passcode lock'),
                    Spacer(),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'I B L E',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Homepage'),
                    Spacer(),
                    Image.asset(
                      'assets/images/icons/arrow_right.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      'Rate us on the AppStore',
                      overflow: TextOverflow.clip,
                    )),
                    Image.asset(
                      'assets/images/icons/star.png',
                      color: ThemeColors.goldCB8355,
                      height: 17,
                    ),
                    Image.asset(
                      'assets/images/icons/star.png',
                      color: ThemeColors.goldCB8355,
                      height: 17,
                    ),
                    Image.asset(
                      'assets/images/icons/star.png',
                      color: ThemeColors.goldCB8355,
                      height: 17,
                    ),
                    Image.asset(
                      'assets/images/icons/star.png',
                      color: ThemeColors.goldCB8355,
                      height: 17,
                    ),
                    Image.asset(
                      'assets/images/icons/star.png',
                      color: ThemeColors.goldCB8355,
                      height: 17,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Share I B L E App'),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Container(
              height: 24,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Help & Policies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.grey2E3235,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Help'),
                    Spacer(),
                    ImageIcon(
                      AssetImage('assets/images/icons/question.png'),
                      size: 20,
                      color: ThemeColors.grey808082,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Application Terms'),
                    Spacer(),
                    ImageIcon(
                      AssetImage('assets/images/icons/note-2.png'),
                      size: 20,
                      color: ThemeColors.grey808082,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                //   return Navigator.push(
                //   context,
                //   SlideFromRightPageRoute(
                //     widget: LanguagePage(),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Text('Privacy Statements'),
                    Spacer(),
                    ImageIcon(
                      AssetImage('assets/images/icons/privacy.png'),
                      size: 20,
                      color: ThemeColors.grey808082,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 65,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: ThemeColors.blue007AFF,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Sign out',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 96),
              child: Row(
                children: [
                  Text('v 6x6 - Made with '),
                  Image.asset(
                    'assets/images/icons/heart (1).png',
                    height: 20,
                  ),
                  Text('in Las Vegas, NV'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
