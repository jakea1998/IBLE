import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

import '../../blocs/categories/categories_bloc.dart';

class CategoryTitle extends StatelessWidget {
  final String text;
  final bool isNote;
  const CategoryTitle({Key? key,required this.text,required this.isNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
                  onLongPress: () {
                    showPersistentDialogFromBottom(
                      context,
                      child: Container(
                        margin: EdgeInsets.only(top: 128, left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.white),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    !isNote ? "CATEGORY NAME" : "NOTE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: ThemeColors.grey595959,
                                          fontSize: 20,
                                        ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/images/icons/close.png'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: ThemeColors.grey595959,
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 26),
                  ),
                );
            
          
          
      
    
  
  }
}
