import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ible/theme.dart';

// class DNotificationDialog extends StatelessWidget {
//   final String content;
//
//   const DNotificationDialog({Key key, @required this.content})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.all(16),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Theme.of(context).backgroundColor,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           children: [
//             Text(
//               this.content ?? '',
//               style: Theme.of(context).textTheme.bodyText1.copyWith(
//                     fontSize: 23,
//                     height: 28,
//                     color: ThemeColors.grey2E3235,
//                     fontWeight: FontWeight.w300,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Future<void> showNotificationDialog(context, String? content) async {
  print('Notification dialog: $content');
  Timer timer = Timer(Duration(seconds: 2, milliseconds: 500), () {
    Navigator.pop(context);
  });
  return await showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: Duration(milliseconds: 350),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            // height: 120,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    content ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 23,
                          color: ThemeColors.grey2E3235,
                          fontWeight: FontWeight.w300,
                        ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 225, left: 20, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  ).then((value) {
    if (timer.isActive) {
      timer.cancel();
    }
    return value;
  });
}

Future<void> showDialogFromBottom(context, {required Widget child}) async {
  print('Yoh');
  Timer timer = Timer(Duration(seconds: 2, milliseconds: 500), () {
    Navigator.of(context).pop();
  });
  return await showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: Duration(milliseconds: 350),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  ).then((value) {
    if (timer.isActive) {
      timer.cancel();
    }
    return value;
  });
}


Future showPersistentDialogFromBottom(context, {required Widget child}) async {
  print('Yoh');
  return await showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: Duration(milliseconds: 350),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
