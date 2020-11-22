import 'package:cost_o_matic/ui/components/scrollables/styled_scrollview.dart';
import 'package:flutter/material.dart';

class StyledScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final FloatingActionButton fab;

  const StyledScaffold({Key key, this.body, this.appBar, this.fab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: StyledScrollView(
        axis: Axis.vertical,
        child: body,
      ),
      floatingActionButton: fab,
    );
  }
}
