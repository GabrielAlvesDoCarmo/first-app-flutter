import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants/Constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                      onPressed: () => registerAppFirebase(),
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

  void registerAppFirebase() {
    if (_passwordController.text == _confirmPasswordController.text) {
      _authService.registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );
    }
  }
}
