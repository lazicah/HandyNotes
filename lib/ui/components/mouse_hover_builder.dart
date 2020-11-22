import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef Widget HoverBuilder(BuildContext context, bool isHovering);

class MouseHoverBuilder extends StatefulWidget {
  final bool isClickable;

  MouseHoverBuilder({Key key, this.builder, this.isClickable = false})
      : super(key: key);

  final HoverBuilder builder;
  @override
  _MouseHoverBuilderState createState() => _MouseHoverBuilderState();
}

class _MouseHoverBuilderState extends State<MouseHoverBuilder> {
  bool isOver = false;

  void setOver(bool value) => setState(() => isOver = value);

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      mouseCursor: widget.isClickable
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onShowHoverHighlight: setOver,
      child: widget.builder(context, isOver),
    );
  }
}
