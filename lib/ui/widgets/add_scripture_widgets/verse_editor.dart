import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ible/ui/widgets/auth_text_input_field.dart';

class VerseEditor extends StatelessWidget {
  final Function(String) validator;
  final TextEditingController verseTextEditingController;
  const VerseEditor({
    Key? key,
    required this.validator,
    required this.verseTextEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ScriptureInputFormField(
        labelText: 'Type verse address',
        validator: (v) => validator(v ??
            "") 
        ,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
          size: 30,
        ),
        onChanged: (newValue) {
          
        },
        controller: verseTextEditingController,
      ),
    );
  }
}
