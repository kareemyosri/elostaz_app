import 'package:elostaz_app/layout/bloc/auth_bloc.dart';
import 'package:elostaz_app/main.dart';
import 'package:elostaz_app/modules/login/login_screen.dart';
import 'package:elostaz_app/modules/product_details/productDetailsScreen.dart';
import 'package:elostaz_app/modules/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeBody(),
      //   );
      case '/ProfileDetailsScreen':
        return MaterialPageRoute(
          builder: (_) => const ProfileDetailsScreen(),
        );
      case '/ProductDetailsScreen':
        final args = settings.arguments as ProductDetailsScreen;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(book: args.book),
        );
      // case '/SettingsPage':
      //   return MaterialPageRoute(builder: (_) => const SettingsPage());
      // case '/NotificationsPage':
      //   return MaterialPageRoute(builder: (_) => const NotificationsPage());
      // case '/ManageAccountScreen':
      //   return MaterialPageRoute(builder: (_) => const ManageAccountScreen());
      // case '/EditUserNameScreen':
      //   return MaterialPageRoute(builder: (_) => const EditUserNameScreen());
      // case '/EditEmailAddress':
      //   return MaterialPageRoute(builder: (_) => const EditEmailAddress());
      // case '/UpdatePassword':
      //   return MaterialPageRoute(builder: (_) => const UpdatePassword());
      // case '/EditProfilePage':
      //   return MaterialPageRoute(builder: (_) => const EditProfilePage());
      // case '/SelectLanguagePage':
      //   return MaterialPageRoute(builder: (_) => const SelectLanguagePage());
      // case '/EditAppAppearancePage':
      //   return MaterialPageRoute(builder: (_) => const EditAppAppearancePage());

      // case '/ConnectedDevicesScreen':
      //   return MaterialPageRoute(
      //       builder: (_) => const ConnectedDevicesScreen());
      // case '/SinglePost':
      //   final args = settings.arguments as SinglePost;
      //   return MaterialPageRoute(
      //     builder: (_) => SinglePost(
      //       post: args.post,
      //       user: args.user,
      //     ),
      //   );
      // case '/CreateNewPostPage':
      //   return MaterialPageRoute(
      //     builder: (_) => const CreateNewPostPage(),
      //   );
      // case '/MessagesScreen':
      //   return MaterialPageRoute(
      //     builder: (_) => const MessagesScreen(),
      //   );
      // case '/ChatDetailPage':
      //   return MaterialPageRoute(
      //     builder: (_) => const ChatDetailPage(),
      //   );
      // case '/ProfileOverview':
      //   return MaterialPageRoute(
      //     builder: (_) => ProfileOverview(),
      //   );
      // case '/AlbumDetailedPage':
      //   final args = settings.arguments as AlbumDetailedPage;
      //   return MaterialPageRoute(
      //     builder: (_) => AlbumDetailedPage(args.albumData),
      //   );
      default:
        return null;
    }
  }
}

List<Page<dynamic>> onGenerateAppViewPages(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authenticated:
      return [HomePage.page()];
    case AuthStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
