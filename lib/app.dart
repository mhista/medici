import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medici/router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark
        // systemStatusBarContrastEnforced: true,
        ));
    return MaterialApp.router(
      routerConfig: routes,
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 600, name: MOBILE),
        const Breakpoint(start: 992, end: 1200, name: TABLET),
        const Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
      ]),
      // smartManagement: SmartManagement.keepFactory,
      // initialBinding: GeneralBindiings(),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      //Scaffold(
      //
      debugShowCheckedModeBanner: false,
    );
  }
}
