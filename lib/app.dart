import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparktech_agency_task/core/utils/themes/theme.dart';
import 'package:sparktech_agency_task/main.dart';
import 'package:sparktech_agency_task/test_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Sparktech Agency Task',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const TestPage(),
      ),
    );
  }
}
