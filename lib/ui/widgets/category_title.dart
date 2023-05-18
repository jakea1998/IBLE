import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/dnotification_dialog.widget.dart';

import '../../blocs/categories/categories_bloc.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.selectedCategory?.parent != "null" &&
                  state.selectedCategory?.parent != null)
                Padding(
                  padding: EdgeInsets.only(right: 7, bottom: 12),
                  child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5))),
                ),
              Flexible(
                child: GestureDetector(
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
                              "CATEGORY NAME",
                              style:
                                  Theme.of(context).textTheme.bodyText1!.copyWith(
                                        color: ThemeColors.grey595959,
                                        fontSize: 20,
                                      ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Image.asset('assets/images/icons/close.png'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            state.selectedCategory?.title ?? "",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                    state.selectedCategory?.title ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
