import 'package:fisrt_app_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class PasswordResetModal extends StatefulWidget {
  const PasswordResetModal({super.key});

  @override
  State<PasswordResetModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<PasswordResetModal> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Recuperar Senha"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: "Digite seu email"),
          validator: (value) {
            if (value!.isEmpty) {
              return "Digite seu email";
            }
            return null;
          },
        ),
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () => resetPassword(context),
          child: Text("Recuperar senha"),
        ),
      ],
    );
  }

  Future<String?> resetPassword(BuildContext context) => _authService
      .resetPassword(email: _emailController.text)
      .then((String? error){
        if (!context.mounted) return;
        Navigator.of(context).pop();
        if (error != null) {
          final snackBar = SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text(
              "Email enviado com sucesso para ${_emailController.text}",
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return null;
      });
}
