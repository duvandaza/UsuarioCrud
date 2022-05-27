import 'package:flutter/material.dart';
import 'package:loginapp/providers/login_form_provider.dart';
import 'package:loginapp/servicios/auth_service.dart';
import 'package:provider/provider.dart';

class RegistrarPage extends StatelessWidget {
  const RegistrarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[400],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40,),
                const Center(child: Text('Crear Cuenta', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                const SizedBox(height: 30,),
                ChangeNotifierProvider(
                  create: ( _ ) => LoginFormProvider(),
                  child: _RegisterForm(),
                ),
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                  child: Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent[400]),)
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final registerForm = Provider.of<LoginFormProvider>(context); 

    return Container(
      width: size.width * 0.6,
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'user@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icon(Icons.alternate_email_rounded)
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '') ? null : 'No es un correo';
              },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline_rounded)
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value){
                return (value != null && value.length >= 6) ? null : 'debe ser de 6 o mas caracteres';
              },
            ),
            const SizedBox(height: 40,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurpleAccent[400],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                child: const Text('Registrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              onPressed: registerForm.isLoading ? null : () async {

                final authService = Provider.of<AuthService>(context, listen: false);

                if(!registerForm.isValidForm()) return;

                registerForm.isLoading = true;
                
                final String? message = await authService.createUser(registerForm.email, registerForm.password);

                if(message == null){
                  Navigator.pushReplacementNamed(context, 'login');
                }else{
                  print(message);
                  registerForm.isLoading = false;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}