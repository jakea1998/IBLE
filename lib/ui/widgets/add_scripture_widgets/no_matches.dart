import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoMatches extends StatelessWidget {
  const NoMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'No Matches Found'.toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'No valid results were found. Please try refining your search.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      color:
                                                          Colors.grey,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );;
  }
}