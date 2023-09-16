// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ible/main.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/ui/pages/category_page.dart';

void main() {
  testWidgets('Favorites Category', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CategoryPage(
      isOpen: true,
      ));

    // Verify that our counter starts at 0.
    
    expect(find.text('Favorites'), findsOneWidget);
    

   
  });
}
