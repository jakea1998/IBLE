import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/language/language_bloc.dart';

class LanguagesPage extends StatefulWidget {
  LanguagesPageState createState() => LanguagesPageState();
}

class LanguagesPageState extends State<LanguagesPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<LanguageBloc>(
      create: (context) => LanguageBloc()..add(LanguageEventFetchLanguages()),
      child: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Languages',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            body: state.languageStatus == LanguageStatus.loaded?Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: state.languagesList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return LanguageListItem(
                      language: state.languagesList?[index],
                    );
                  }),
            ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),),
          );
        },
      ),
    );
  }
}

class LanguageListItem extends StatelessWidget {
  final String? language;
  
  const LanguageListItem({this.language,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap:(){},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                language ?? '',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
              ),
            ),
            /*  Divider(
              height: 1,
              color: Colors.grey,
            ) */
          ],
        ),
      ),
    );
  }
}
