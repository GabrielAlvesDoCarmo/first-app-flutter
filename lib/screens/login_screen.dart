import 'package:fisrt_app_flutter/screens/modal/reset_password_modal.dart';
import 'package:fisrt_app_flutter/screens/register_screen.dart';
import 'package:fisrt_app_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../utils/constants/Constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(Constants.spacing_16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(Constants.spacing_16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Constants.spacing_16),
              ),
              child: Column(
                children: [
                  const FlutterLogo(size: Constants.spacing_76),
                  const SizedBox(height: Constants.spacing_16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: Constants.emailHint,
                    ),
                  ),
                  const SizedBox(height: Constants.spacing_16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: Constants.passwordHint,
                    ),
                  ),
                  const SizedBox(height: Constants.spacing_16),
                  ElevatedButton(
                    onPressed: () => loginApp(context),
                    child: const Text(Constants.loginApp),
                  ),
                  const SizedBox(height: Constants.spacing_16),
                  ElevatedButton(
                    onPressed: () => (),
                    child: const Text(Constants.loginAppWithGoogle),
                  ),
                  const SizedBox(height: Constants.spacing_16),
                  TextButton(
                    onPressed: () => goToRegisterScreen(context),
                    child: const Text(Constants.createAccount),
                  ),
                  TextButton(onPressed: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return const PasswordResetModal();
                    });
                  }, child: const Text("Recuperar senha!"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  goToRegisterScreen(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterScreen()),
  );

  loginApp(BuildContext context) {
    authService
        .login(email: _emailController.text, password: _passwordController.text)
        .then((String? error) {
          if (!context.mounted) return;
          if (error != null) {
            final snackBar = SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
  }
}
