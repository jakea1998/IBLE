import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ible/theme.dart';


class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SaveButton({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 4),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8),
                        child: OutlinedButton(
                          onPressed: () async {
                            
                            onPressed();
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            side:
                                BorderSide(width: 2, color: Color(0xFFA7B0B3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 18),
                            child: Text(
                              'Save',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: ThemeColors.saveText(context),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SFUIText',
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
  }
}