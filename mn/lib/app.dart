import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'routing/app_router.dart';
import 'features/news/bloc/news_bloc.dart';
import 'features/news/data/repositories/news_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => NewsRepository(),
      child: BlocProvider(
        create: (context) => NewsBloc(context.read<NewsRepository>())..add(LoadNews()),
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => NewsRepository(),
      child: BlocProvider(
        create: (context) => NewsBloc(context.read<NewsRepository>())..add(LoadNews()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }

