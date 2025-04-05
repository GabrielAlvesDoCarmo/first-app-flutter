import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class Menu extends StatelessWidget {
  final User user;

  const Menu({super.key, required this.user});

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
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 48,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: () => AuthService().logout(),
          )
        ],
      ),
    );
  }
}
