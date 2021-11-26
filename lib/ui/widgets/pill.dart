import 'package:flutter/material.dart';
import 'package:ible/theme.dart';

class Pill extends StatelessWidget {
  final String text;

  const Pill({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColors.greyABABAB),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ThemeColors.grey808082,
            ),
      ),
    );
  }
}