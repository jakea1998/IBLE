import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ible/ui/widgets/auth_text_input_field.dart';

class CategoryEditorEnabled extends StatelessWidget {
  final TextEditingController categoryTextEditingController;
  final String hintText;
  const CategoryEditorEnabled(
      {Key? key,
      required this.hintText,
      required this.categoryTextEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 12.0, top: 28.0, left: 16.0, right: 16.0),
      child: GestureDetector(
        child: ScriptureInputFormField(
          labelText: hintText,
          validator: (p0) {
            if (p0 == "" || p0 == hintText) {
              return "";
            }
            return null;
          },
          onChanged: (newValue) {
            String title = newValue;
            /* if (title.isNotEmpty) {
              title[0].toUpperCase();
              categoryTextEditingController.value = TextEditingValue(
                text: title,
                selection: TextSelection.collapsed(offset: title.length),
              );
            } */
          },
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          controller: categoryTextEditingController,
        ),
      ),
    );
  }
}
