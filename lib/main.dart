import 'package:elostaz_app/share/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/login/login_screen.dart';
import 'share/utils/custom_theme.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        final customTheme = CustomTheme(constraints);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Series 2 Ecommerce',
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
          ),
          home: LoginScreen(),
        );
      },
    );
  }
}
