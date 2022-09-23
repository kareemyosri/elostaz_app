import 'package:elostaz_app/layout/app_layout.dart';
import 'package:elostaz_app/layout/bloc/auth_bloc.dart';
import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/share/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/login/login_screen.dart';
import 'share/utils/custom_theme.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // print(constraints.maxWidth);
        final customTheme = CustomTheme(constraints);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
          ),
          home: BlocProvider(
            create: (context) => AuthBloc(authRepo: AuthRepo()),
            child: const Wrapper(),
          ),
        );
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return const HomePage();
        } else if (state.status == AuthStatus.unauthenticated) {
          return const LoginScreen();
        }
        return Container();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AppCubit>(create: ((context) => AppCubit())),
    ], child: const LayoutScreen());
  }
}
