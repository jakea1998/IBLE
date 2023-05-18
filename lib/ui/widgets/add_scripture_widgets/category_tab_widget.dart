import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/tab_indicator.dart';

class CategoryTabWidget extends StatelessWidget {
  final TabController tabController;
  const CategoryTabWidget({Key? key,required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: ThemeColors.greyECECEC,
            borderRadius: BorderRadius.circular(8)),
        child: TabBar(
          controller: tabController,
          labelStyle: TextStyle(
            fontFamily: 'San Francisco',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.black,
          ),
          indicator: PillTabIndicator(),
          unselectedLabelColor: ThemeColors.grey808082,
          labelColor: Colors.black,
          indicatorColor: ThemeColors.grey2E3235,
          labelPadding: EdgeInsets.symmetric(vertical: 5),
          indicatorWeight: 0,
          tabs: <Widget>[
            const Text("New Category"),
            const Text("Existing Category"),
          ],
        ),
      ),
    );
    ;
  }
}
