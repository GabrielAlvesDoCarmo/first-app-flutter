import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants/Constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(Constants.spacing_16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(Constants.spacing_16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.spacing_16),
                ),
                child: Column(
                  children: [
                    const FlutterLogo(size: Constants.spacing_76),
                    const SizedBox(height: Constants.spacing_16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: Constants.nameHint,
                      ),
                    ),
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
                      decoration: InputDecoration(
                        hintText: Constants.passwordHint,
                      ),
                    ),
                    const SizedBox(height: Constants.spacing_16),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: Constants.confirmPasswordHint,
                      ),
                    ),
                    const SizedBox(height: Constants.spacing_16),
                    ElevatedButton(
                      onPressed: () => registerAppFirebase(context),
                      child: const Text(Constants.createAccount),
                    ),
                    const SizedBox(height: Constants.spacing_16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void registerAppFirebase(BuildContext context) {
    if (_passwordController.text == _confirmPasswordController.text) {
      passwordsEquals(context);
    } else {
      passwordsNotEquals(context);
    }
  }

  void passwordsEquals(BuildContext context) {
    _authService.registerUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    ).then((String? error) {
      if (!context.mounted) return;
      showSnackBar(error, context);
    });
  }

  void passwordsNotEquals(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("Senhas nao correspondem!!!!"),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBar(String? error, BuildContext context) {
    if (error != null) {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.pop(context);
    }
  }




}
