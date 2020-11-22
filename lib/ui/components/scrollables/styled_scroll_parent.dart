import 'package:cost_o_matic/ui/components/scrollables/styled_scroll_bar.dart';
import 'package:cost_o_matic/ui/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:cost_o_matic/ui/utils/ui_extensions.dart';

class ScrollParent extends StatelessWidget {
  final double barSize;
  final Axis axis;
  final ChangeNotifier rebuildNotifier;
  final Widget child;
  final ScrollController controller;
  final double contentSize;
  final EdgeInsets scrollbarPadding;
  final Color handleColor;
  final Color trackColor;

  const ScrollParent(
      {Key key,
      this.barSize,
      this.axis,
      this.rebuildNotifier,
      this.child,
      this.controller,
      this.contentSize,
      this.scrollbarPadding,
      this.handleColor,
      this.trackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// CHILD
        /// Wrap with a bit of padding on the right
        child.padding(
          right: axis == Axis.vertical ? barSize + Insets.sm : 0,
          bottom: axis == Axis.horizontal ? barSize + Insets.sm : 0,
        ),

        /// SCROLLBAR
        Padding(
          padding: scrollbarPadding ?? EdgeInsets.zero,
          child: StyledScrollbar(
            size: barSize,
            axis: axis,
            controller: controller,
            contentSize: contentSize,
            trackColor: trackColor,
            handleColor: handleColor,
            showTrack: true,
          ),
        ),
      ],
    );
  }
}
