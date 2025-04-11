import 'package:fisrt_app_flutter/screens/modal/delete_account.dart';
import 'package:fisrt_app_flutter/screens/modal/reset_password_modal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class Menu extends StatelessWidget {
  final User user;
  final AuthService _authService = AuthService();

  Menu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName ?? ""),
            accountEmail: Text(user.email ?? ""),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.manage_accounts_rounded, size: 48),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: () => _authService.logout(),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: const Text("Excluir conta"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DeleteAccount();
                }
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: const Text("Alterar senha"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PasswordResetModal();
                }
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteAccount() async {
    await _authService.excludedAccount(password: "123123123");
    await _authService.logout();
  }
}
