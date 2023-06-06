 import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


typedef ToggleStyleButtonBuilder = Widget Function(
  BuildContext context,
  Attribute attribute,
  IconData icon,
  Color? fillColor,
  bool? isToggled,
  VoidCallback? onPressed, [
  double iconSize,
]);

typedef DToggleStyleButtonBuilder = Widget Function({
  required BuildContext context,
  required Attribute attribute,
  IconData? icon,
  Widget? iconWidget,
  Color? fillColor,
  bool? isToggled,
  VoidCallback? onPressed,
  double iconSize,
});

class DToggleStyleButton extends StatefulWidget {
  const DToggleStyleButton({
    required this.attribute,
    this.icon,
    this.iconWidget,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.childBuilder = dDefaultToggleStyleButtonBuilder,
    Key? key,
  }) : super(key: key);

  final Attribute attribute;

  final IconData? icon;
  final Widget? iconWidget;
  final double iconSize;

  final Color? fillColor;

  final QuillController controller;

  final DToggleStyleButtonBuilder childBuilder;

  @override
  _DToggleStyleButtonState createState() => _DToggleStyleButtonState();
}

class _DToggleStyleButtonState extends State<DToggleStyleButton> {
  bool? _isToggled;

  Style get _selectionStyle => widget.controller.getSelectionStyle();

  @override
  void initState() {
    super.initState();
    _isToggled = _getIsToggled(_selectionStyle.attributes);
    widget.controller.addListener(_didChangeEditingValue);
  }

  @override
  Widget build(BuildContext context) {
    final isInCodeBlock =
        _selectionStyle.attributes.containsKey(Attribute.codeBlock.key);
    final isEnabled =
        !isInCodeBlock || widget.attribute.key == Attribute.codeBlock.key;
    return widget.childBuilder(
      context: context,
      attribute: widget.attribute,
      icon: widget.icon,
      iconWidget: widget.iconWidget,
      fillColor: widget.fillColor,
      isToggled: _isToggled,
      onPressed: isEnabled ? _toggleAttribute : null,
      iconSize: widget.iconSize,
    );
  }

  @override
  void didUpdateWidget(covariant DToggleStyleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
      _isToggled = _getIsToggled(_selectionStyle.attributes);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }

  void _didChangeEditingValue() {
    setState(() => _isToggled = _getIsToggled(_selectionStyle.attributes));
  }

  bool _getIsToggled(Map<String, Attribute> attrs) {
    if (widget.attribute.key == Attribute.list.key) {
      final attribute = attrs[widget.attribute.key];
      if (attribute == null) {
        return false;
      }
      return attribute.value == widget.attribute.value;
    }
    return attrs.containsKey(widget.attribute.key);
  }

  void _toggleAttribute() {
    widget.controller.formatSelection(_isToggled!
        ? Attribute.clone(widget.attribute, null)
        : widget.attribute);
  }
}

Widget defaultToggleStyleButtonBuilder(
  BuildContext context,
  Attribute attribute,
  IconData icon,
  Color? fillColor,
  bool? isToggled,
  VoidCallback? onPressed, [
  double iconSize = kDefaultIconSize,
]) {
  final theme = Theme.of(context);
  final isEnabled = onPressed != null;
  final iconColor = isEnabled
      ? isToggled == true
          ? theme.primaryIconTheme.color
          : theme.iconTheme.color
      : theme.disabledColor;
  final fill = isToggled == true
      ? theme.toggleableActiveColor
      : fillColor ?? theme.canvasColor;
  return QuillIconButton(
    highlightElevation: 0,
    hoverElevation: 0,
    size: iconSize * kIconButtonFactor,
    icon: Icon(icon, size: iconSize, color: iconColor),
    fillColor: fill,
    onPressed: onPressed,
  );
}

Widget dDefaultToggleStyleButtonBuilder({
  required BuildContext context,
  required Attribute attribute,
  IconData? icon,
  Widget? iconWidget,
  Color? fillColor,
  bool? isToggled,
  VoidCallback? onPressed,
  double iconSize = kDefaultIconSize,
}) {
  final theme = Theme.of(context);
  final isEnabled = onPressed != null;
  final iconColor = isEnabled
      ? isToggled == true
          ? theme.primaryIconTheme.color
          : theme.iconTheme.color
      : theme.disabledColor;
  final fill = isToggled == true
      ? theme.toggleableActiveColor
      : fillColor ?? theme.canvasColor;
  return QuillIconButton(
    highlightElevation: 0,
    hoverElevation: 0,
    size: iconSize * kIconButtonFactor,
    icon: iconWidget ??
        Icon(icon, size: iconSize, color: iconColor),
    fillColor: fill,
    onPressed: onPressed,
  );
}
