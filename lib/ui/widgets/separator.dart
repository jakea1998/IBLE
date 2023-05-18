import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ible/theme.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                    margin: EdgeInsets.only(
                      left: 16,
                    ),
                    height: 0.5,
                    color: ThemeColors.greyB2B2B2,
                  );;
  }
}