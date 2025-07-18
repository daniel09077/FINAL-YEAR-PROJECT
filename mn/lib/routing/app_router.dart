import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/news/presentation/pages/news_feed_page.dart';
import '../features/news/presentation/pages/news_detail_page.dart';
import '../features/news/data/models/news_model.dart';
import '../features/news/presentation/pages/admin_upload_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/presentation/pages/login_page.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const NewsFeedPage(),
      ),

      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),

      GoRoute(
        path: '/admin-upload',
        builder: (context, state) {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) return const LoginPage();
          return const AdminUploadPage();
        },
      ),

      GoRoute(
        path: '/login',
        redirect: (context, state) {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) return '/admin-upload'; // already logged in
          return null;
        },
        builder: (_, __) => const LoginPage(),
      ),

      GoRoute(
      path: '/admin-upload',
      builder: (_, __) => const AdminUploadPage(),
      ),
      GoRoute(
        path: '/news-detail',
        builder: (context, state) {
          final news = state.extra! as NewsModel;
          return NewsDetailPage(news: news);
        },
      ),
    ],
  );
}
