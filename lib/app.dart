import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparktech_agency_task/core/utils/themes/theme.dart';
import 'package:sparktech_agency_task/features/auth/presentation/blocs/otp/otp_bloc.dart';
import 'package:sparktech_agency_task/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:sparktech_agency_task/features/auth/presentation/pages/splash_page.dart';
import 'package:sparktech_agency_task/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => OtpBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Sparktech Agency Task',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashPage(),
      ),
    );
  }
}
