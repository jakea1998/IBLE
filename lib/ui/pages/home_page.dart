import 'package:flutter/material.dart';


import 'package:ible/theme.dart';

import '../widgets/sliding_scaffold_new.dart';

//This shows the root of the application
//All widgets
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
      isOpen: false,
      title: Text(
        "Ible",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: ImageIcon(AssetImage('assets/images/icons/more.png'),
                  color: ThemeColors.appBarIconColor),
            )),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: ImageIcon(
              AssetImage('assets/images/icons/share.png'),
              size: 26.0,
              color: ThemeColors.appBarIconColor,
            ),
          ),
        ),
      ],
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('Homepage'),
              /* Consumer<AuthController>(
                  builder: (context, authController, child) {
                if (authController.user == null)
                  return RaisedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    ),
                    child: Text('Log In'),
                  );
                return Column(
                  children: [
                    Text(
                        'Logged in as ${authController.user!.username ?? authController.user!.email}'),
                    RaisedButton(
                      onPressed: authController.logout,
                      child: Text('Logout'),
                    )
                  ],
                );
              }), */
            ],
          ),
        ),
      ),
    );
  }
}