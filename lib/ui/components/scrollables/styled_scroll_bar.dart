
import 'package:cost_o_matic/ui/components/mouse_hover_builder.dart';
import 'package:cost_o_matic/ui/utils/styles/app_theme.dart';
import 'package:cost_o_matic/ui/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cost_o_matic/ui/utils/ui_extensions.dart';

class StyledScrollbar extends StatefulWidget {
  final double size;
  final Axis axis;
  final ScrollController controller;
  final Function(double) onDrag;
  final bool showTrack;
  final Color handleColor;
  final Color trackColor;

  final double contentSize;

  const StyledScrollbar(
      {Key key, this.size, this.axis, this.controller, this.onDrag, this.contentSize, this.showTrack = false, this.handleColor, this.trackColor})
      : super(key: key);

  @override
  ScrollbarState createState() => ScrollbarState();
}

class ScrollbarState extends State<StyledScrollbar> {
  double _viewExtent = 100;
  

  @override
  void initState() {
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void didUpdateWidget(StyledScrollbar oldWidget) {
    if (oldWidget.contentSize != widget.contentSize) setState(() {});
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxExtent;
        switch (widget.axis) {
          case Axis.vertical:
            // Use supplied contentSize if we have it, otherwise just fallback to maxScrollExtents
            maxExtent = (widget.contentSize != null && widget.contentSize > 0)
                ? widget.contentSize - constraints.maxHeight
                : widget.controller?.position?.maxScrollExtent ?? 0;
            _viewExtent = constraints.maxHeight;

            break;
          case Axis.horizontal:
            // Use supplied contentSize if we have it, otherwise just fallback to maxScrollExtents
            maxExtent = (widget.contentSize != null && widget.contentSize > 0)
                ? widget.contentSize - constraints.maxWidth
                : widget.controller?.position?.maxScrollExtent ?? 0;
            _viewExtent = constraints.maxWidth;

            break;
        }

        double contentExtent = maxExtent + _viewExtent;
        // Calculate the alignment for the handle, this is a value between 0 and 1,
        // it automatically takes the handle size into acct
        double handleAlignment = maxExtent == 0 ? 0 : widget.controller.offset / maxExtent;

        // Convert handle alignment from [0, 1] to [-1, 1]
        handleAlignment *= 2.0;
        handleAlignment -= 1.0;

        // Calculate handleSize by comparing the total content size to our viewport
        double handleExtent = _viewExtent;
        if (contentExtent > _viewExtent) {
          //Make sure handle is never small than the minSize
          handleExtent = max(60, _viewExtent * _viewExtent / contentExtent);
        }
        // Hide the handle if content is < the viewExtent
        bool showHandle = contentExtent > _viewExtent && contentExtent > 0;
        // Handle color
        Color handleColor = widget.handleColor ?? (
            theme.isDark ? theme.greyWeak.withOpacity(.2) : theme.greyWeak);
        // Track color
        Color trackColor = widget.trackColor ?? (
            theme.isDark ? theme.greyWeak.withOpacity(.1) : theme.greyWeak.withOpacity(.3));

        //Layout the stack, it just contains a child, and
        return Stack(children: <Widget>[
          /// TRACK, thin strip, aligned along the end of the parent
          if (widget.showTrack)
            Align(
              alignment: Alignment(1, 1),
              child: Container(
                color: trackColor,
                width: widget.axis == Axis.vertical ? widget.size : double.infinity,
                height: widget.axis == Axis.horizontal ? widget.size : double.infinity,
              ),
            ),

          /// HANDLE - Clickable shape that changes scrollController when dragged
          Align(
            // Use calculated alignment to position handle from -1 to 1, let Alignment do the rest of the work
            alignment: Alignment(
              widget.axis == Axis.vertical ? 1 : handleAlignment,
              widget.axis == Axis.horizontal ? 1 : handleAlignment,
            ),
            child: GestureDetector(
              onVerticalDragUpdate: _handleVerticalDrag,
              onHorizontalDragUpdate: _handleHorizontalDrag,
              // HANDLE SHAPE
              child: MouseHoverBuilder(
                builder: (_, isHovered) => Container(
                  width: widget.axis == Axis.vertical ? widget.size : handleExtent,
                  height: widget.axis == Axis.horizontal ? widget.size : handleExtent,
                  decoration: BoxDecoration(color: handleColor.withOpacity(isHovered? 1 : .85), borderRadius: Corners.s3Border),
                ),
              ),
            ),
          )
        ]).opacity(showHandle ? 1.0 : 0.0, animate: false);
      },
    );
  }

  void _handleHorizontalDrag(DragUpdateDetails details) {
    double pos = widget.controller.offset;
    double pxRatio = (widget.controller.position.maxScrollExtent + _viewExtent) / _viewExtent;
    widget.controller.jumpTo((pos + details.delta.dx * pxRatio).clamp(0.0, widget.controller.position.maxScrollExtent));
    widget.onDrag?.call(details.delta.dx);
  }

  void _handleVerticalDrag(DragUpdateDetails details) {
    double pos = widget.controller.offset;
    double pxRatio = (widget.controller.position.maxScrollExtent + _viewExtent) / _viewExtent;
    widget.controller.jumpTo((pos + details.delta.dy * pxRatio).clamp(0.0, widget.controller.position.maxScrollExtent));
    widget.onDrag?.call(details.delta.dy);
  }
}
