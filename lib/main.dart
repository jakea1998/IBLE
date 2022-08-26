import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';
import 'package:ible/blocs/categories/categories_bloc.dart';
import 'package:ible/blocs/save_verses/save_verse_bloc.dart';
import 'package:ible/blocs/scriptures/scriptures_bloc.dart';
import 'package:ible/blocs/verse/verse_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ible/theme.dart';
import 'package:ible/ui/pages/category.page.dart';
import 'package:ible/ui/pages/home_page.dart';

import 'models/category_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    MyApp state = context.findAncestorStateOfType<MyApp>()!;
    state.changeLanguage(newLocale);
  }

  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  // This widget is the root of your application.
  Locale? _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Future<Widget> getHomeScreen(fluent.BuildContext context) async {
    try {
      final _auth = FirebaseAuth.instance;
      final user = _auth.currentUser;
      if (user == null) {
        await _auth.signInAnonymously();

        print('signed in anonymously');
        /* BlocProvider.of<ScripturesBloc>(context)
          ..add(ScripturesEventSelectCategory(
            category: Category(
              id: 2,
              title: 'Favorites',
            ),
          )); */
        return CategoryPage(
          category: Category(
            id: 2,
            title: 'Favorites',
          ),
        );
      } else {
        print('signed in');
        /* BlocProvider.of<ScripturesBloc>(context)
          ..add(ScripturesEventSelectCategory(
            category: Category(
              id: 2,
              title: 'Favorites',
            ),
          )); */
        return CategoryPage(
          category: Category(
            id: 2,
            title: 'Favorites',
          ),
        );
      }
    } catch (e) {
      print(e);
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SaveVerseBloc>(
          create: (context) => SaveVerseBloc(),
        ),
        BlocProvider<ScripturesBloc>(
          create: (context) =>
              ScripturesBloc()..add(ScripturesEventLoadScriptures()),
        ),
        BlocProvider<VerseBloc>(
          create: (context) => VerseBloc(),
        ),
        BlocProvider<BibleVersionBloc>(
            create: (context) => BibleVersionBloc()
              ..add(BibleVersionFetchSavedBibleVersion())
              ..add(BibleVersionEventFetchAllBibleVersions())),
        BlocProvider<CategoriesBloc>(
          create: (context) =>
              CategoriesBloc()..add(CategoriesEventLoadCategories()),
        ),
      ],
      child: fluent.FluentApp(
          debugShowCheckedModeBanner: false,
          title: 'IBLE',
          home: FutureBuilder<Widget>(
            future: getHomeScreen(context),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return snapshot.data ?? Container();
              else
                return Container();
            },
          )),
    );
  }
}

class IbleSplashPage extends StatefulWidget {
  @override
  _IbleSplashPageState createState() => _IbleSplashPageState();
}

class _IbleSplashPageState extends State<IbleSplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final Duration duration = const Duration(milliseconds: 1000);

  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.addListener(() {
      //setState(() {});
    });
    _animationController.forward();
    Timer(
      Duration(milliseconds: 1500),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => CategoryPage(
            category: Category(
              id: 2,
              title: 'Favorites',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        SlideTransition(
          position: _slideAnimation,
          child: Container(
            color: ThemeColors.grey2E3235,
          ),
        ),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
                color: _animationController.value < 0.4
                    ? ThemeColors.grey414747
                    : Colors.white,
              ),
          child: Center(
            child: Text('IBLE'),
          ),
        ),
      ],
    );
  }
}
