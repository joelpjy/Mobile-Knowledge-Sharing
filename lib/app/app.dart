import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/app/config.router.dart';
import 'package:stacked_services/stacked_services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
