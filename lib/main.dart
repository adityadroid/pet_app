import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/constants.dart';
import 'package:pet_app/home/bloc/home_bloc.dart';
import 'package:pet_app/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/bloc/login_bloc.dart';
import 'login/login_page.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final authService = AuthService();
  final isLoggedIn = sharedPreferences.containsKey(ACCESS_TOKEN);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(authService, sharedPreferences),
    ),
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(sharedPreferences),
    ),
  ], child: PetApp(isLoggedIn)));
}

class PetApp extends StatelessWidget {
  final bool isLoggedIn;
  PetApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: isLoggedIn ? HomePage() : LoginPage());
  }
}
