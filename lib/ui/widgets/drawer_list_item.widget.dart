import 'package:flutter/material.dart';
import 'package:ible/theme.dart';

class DrawerListItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget? iconWidget;
  final Function? onTap;
  final Function? onLongPress;
  final int? count;
  final bool selected;
  final Widget? trailingIconWidget;

  const DrawerListItem({
    Key? key,
    this.title,
    this.icon,
    this.iconWidget,
    this.trailingIconWidget,
    this.onTap,
    this.onLongPress,
    this.count,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: selected ? ThemeColors.grey4A5151 : Colors.transparent,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: this.iconWidget ??
                  Icon(
                    icon,
                    color: ThemeColors.grey808082,
                  ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: selected ? Colors.white : ThemeColors.greyBCBCCO,
                          fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (count != null && count! > 0)
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Container(
                        width: count! < 10 ? 24 : 48,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '$count',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: ThemeColors.greyBCBCCO,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (trailingIconWidget != null)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: trailingIconWidget,
              ),
          ],
        ),
      ),
      onTap: onTap as void Function()?,
      onLongPress: onLongPress as void Function()?,
    );
  }
}
