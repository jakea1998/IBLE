
import 'package:flutter/material.dart';

class NoVersesFound extends StatelessWidget {
  const NoVersesFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Verses Found.',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 24),
                  ),
                ));
  }
}