import 'package:elostaz_app/layout/bloc/auth_bloc.dart';
import 'package:elostaz_app/main.dart';
import 'package:elostaz_app/modules/login/login_screen.dart';
import 'package:flutter/material.dart';

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
