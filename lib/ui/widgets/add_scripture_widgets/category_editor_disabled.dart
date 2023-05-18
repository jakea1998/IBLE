import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/ui/widgets/auth_text_input_field.dart';
import 'package:ible/utils/pick_cat_dialog.dart';

class CategoryEditorDisabled extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;
  final TextEditingController categoryTextEditingController;
 
  
  const CategoryEditorDisabled(
      {Key? key, required this.hintText, 
      required this.onTap,
      required this.categoryTextEditingController,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 12.0, top: 28.0, left: 16.0, right: 16.0),
      child: GestureDetector(
        onTap:  onTap,
        child: ScriptureInputFormField(
          labelText: hintText,
          enabled: false,
          validator: (p0) {
            if (p0 == "" || p0 == hintText) {
              return "";
            }
            return null;
          },
          onChanged: (newValue) {
            /* String title = newValue;
            
            if (title.isNotEmpty) {
              title[0].toUpperCase();
              categoryTextEditingController.value = TextEditingValue(
                text: title,
                selection: TextSelection.collapsed(offset: title.length),
              ); */
            //}
          },
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          controller: categoryTextEditingController,
        ),
      ),
    );
  }
}
