import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:temparty/app/data/data_sources/user/user_local_data_source.dart';
import 'package:temparty/app/repositories/user_repository.dart';

@injectable
class AuthRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final UserLocalDataSource _userLocal;
  final UserRepository _userRepository;

  AuthRepository(this._userLocal, this._userRepository);

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      await _userRepository.loginUser();
      Modular.to.pushReplacementNamed('/main');
    } on FirebaseAuthException {
      Fluttertoast.showToast(
        msg: 'Usuário ou senha incorretos',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.deepPurple,
      );
    }
  }

  Future<void> register(String email, String name, String date, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final userData = {
        "userUid": credential.user!.uid,
        "displayName": name,
        "email": email,
        "birthday": date,
      };
      await _userRepository.createUserData(userData);
      Modular.to.pushReplacementNamed('/main');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'Senha muito fraca, use números, caracteres especiais etc.',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.deepPurple,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'Esta email já está cadastrado no aplicativo, efetue o login.',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.deepPurple,
        );
      }
    }
  }

  Future<void> logout() async {
    try {
      await _userLocal.deleteUserData();
      print(await _userLocal.getUserData());
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e as String,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.deepPurple,
      );
    }
  }
}
