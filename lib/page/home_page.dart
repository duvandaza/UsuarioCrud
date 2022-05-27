import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loginapp/servicios/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.logout_outlined, color: Colors.red, size: 25,),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Text('Bienvenido'),
      ),
    );
  }
}