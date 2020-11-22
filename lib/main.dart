import 'package:cost_o_matic/core/app/state/app_state.dart';
import 'package:cost_o_matic/main_router.dart';
import 'package:cost_o_matic/providers.dart';
import 'package:cost_o_matic/ui/utils/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:cost_o_matic/ui/utils/ui_extensions.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeType themeType =
        context.select<AppState, ThemeType>((value) => value.themeType);
    AppTheme theme = AppTheme.fromType(themeType);
    return Provider.value(
      value: theme,
      child: MaterialApp(
        title: AppTheme.name,
        theme: theme.themeData,
        home: CoreManager(),
        onGenerateRoute: MainRouter.generateRoute,
      ),
    );
  }
}

class CoreManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
