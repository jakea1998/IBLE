import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PillTabIndicator extends Decoration {
  final double indicatorHeight;

  PillTabIndicator({this.indicatorHeight = 28});
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return new _CustomPainter(this, onChanged);
  }

}

class _CustomPainter extends BoxPainter {

  final PillTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback? onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    // final Rect rect = offset & configuration.size;
    final indicatorHeight = decoration.indicatorHeight;
    final Rect rect = Offset(offset.dx, (configuration.size!.height/2) - indicatorHeight/2) & Size(configuration.size!.width, indicatorHeight);
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(8.0)), paint);
  }

}