import 'package:flutter/material.dart';

class NoScripturesSaved extends StatelessWidget {
  const NoScripturesSaved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Scriptures Saved.',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 24),
                  ),
                ));
  }
}