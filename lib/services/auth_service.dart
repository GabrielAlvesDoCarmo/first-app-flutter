import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Usuário não encontrado';
        case 'wrong-password':
          return 'Senha incorreta';
        default:
          return 'Erro ao fazer login';
      }
    }
    return null;
  }

  Future<String?> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'A senha é muito fraca';
        case 'email-already-in-use':
          return 'O email já está em uso';
        default:
          return 'Erro ao registrar usuário';
      }
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Usuário não encontrado';
        default:
          return 'Erro ao enviar email de redefinição de senha';
      }
    }
  }

  Future<String?> excludedAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return 'Faça login novamente para excluir a conta';
        default:
          return 'Erro ao excluir a conta';
      }
    }
  }
}
