import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final AuthService _authService = AuthService();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Excluir Conta"),
      content: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(labelText: "Digite sua senha"),
        validator: (value) {
          if (value!.isEmpty) {
            return "Digite sua senha";
          }
          return null;
        },
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () => excludedAccount(context),
          child: Text("Excluir Conta"),
        ),
      ],
    );
  }

  void excludedAccount(BuildContext context) {
    _authService.excludedAccount(password: _passwordController.text);
    Navigator.pop(context);
  }
}
