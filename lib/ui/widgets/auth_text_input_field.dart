import 'package:flutter/material.dart';
import 'package:ible/theme.dart';

class ScriptureInputFormField extends StatelessWidget {
  final String? labelText;
  final bool enabled;
  final Function(String)? validator;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  
  const ScriptureInputFormField({
    Key? key,
    this.labelText,
    this.enabled = true,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.onTap,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontSize: 20, color: Colors.grey[500]),
      decoration: InputDecoration(
        hintText: labelText,
        
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
              color: Colors.grey[500],
              
            ),
        filled: true,
        fillColor: Colors.grey[200],
        isDense: true,
        prefixIcon: prefixIcon != null ? prefixIcon : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),

        /* enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.0),
          borderSide: BorderSide(color: ThemeColors.greyB2B2B2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.0),
          borderSide: BorderSide(color: ThemeColors.greyB2B2B2, width: 1),
        ), */
        focusColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),

        /*  errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26.0),
          borderSide: BorderSide(color: ThemeColors.redDD4C4F, width: 1),
        ), */
        errorStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: ThemeColors.redDD4C4F,
              fontSize: 14,
            ),
      ),
      validator: validator as String? Function(String?)?,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
