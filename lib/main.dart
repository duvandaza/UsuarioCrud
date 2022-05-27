import 'package:flutter/material.dart';
import 'package:loginapp/page/home_page.dart';
import 'package:loginapp/servicios/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:loginapp/page/login_page.dart';
import 'package:loginapp/page/registro_page.dart';

void main() async {
  runApp(AppState());
} 

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login'  : ( _ ) => LoginPage(),
        'registrar' : ( _ ) => RegistrarPage(),
        'home' : ( _ ) => HomePage(),
      },
    );
  }
}