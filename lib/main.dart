import 'package:elostaz_app/layout/app_layout.dart';
import 'package:elostaz_app/layout/bloc/auth_bloc.dart';
import 'package:elostaz_app/layout/cubit/app_cubit.dart';
import 'package:elostaz_app/modules/Profile/cubit/user_cubit.dart';
import 'package:elostaz_app/modules/register/register_screen.dart';
import 'package:elostaz_app/repo/auth.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:elostaz_app/share/observer.dart';
import 'package:elostaz_app/share/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/login/login_screen.dart';
import 'share/utils/custom_theme.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authRepo = AuthRepo();
  await authRepo.user.first;
  runApp(MyApp(authRepo: authRepo));
}

class MyApp extends StatelessWidget {
  const MyApp({required AuthRepo authRepo, super.key}) : _authRepo = authRepo;
  final AuthRepo _authRepo;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (context) => AuthBloc(authRepo: _authRepo),
        child: const Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    String uid = context.read<AuthBloc>().state.user.uid;
    final DatabaseRepo databaseRepo = DatabaseRepo(uid: uid);
    final AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: ((context) => AppCubit())),
          BlocProvider<UserCubit>(
              create: ((context) => UserCubit(databaseRepo: databaseRepo))),
        ],
        child: LayoutBuilder(
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
              onGenerateRoute: appRouter.onGenerateRoute,
              home: const LayoutScreen(),
            );
          },
        ));
  }
}
