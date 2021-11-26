import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ible/blocs/bible_version/bible_version_bloc.dart';

class VersionsPage extends StatefulWidget {
  VersionsPageState createState() => VersionsPageState();
}

class VersionsPageState extends State<VersionsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<BibleVersionBloc>(
      create: (context) => BibleVersionBloc()..add(BibleVersionEventFetchAllBibleVersions()),
      child: BlocConsumer<BibleVersionBloc, BibleVersionState>(
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
                  title: Text('Versions',style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
                ),
                body: state.status == BibleVersionStatus.loaded ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: state.model?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return VersionListItem(
                                version: state.model?.data?[index].name,
                              );
                            }),
                      ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),),
              );
        },
      ),
    );
  }
}
class VersionListItem extends StatelessWidget {
  final String? version;
  
  const VersionListItem({this.version,});

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
                version ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
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
