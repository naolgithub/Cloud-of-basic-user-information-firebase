import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile_flutter/models/client_user.dart';
import 'package:profile_flutter/providers/user_provider.dart';
import 'package:profile_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthMethods {
  final _userReference = FirebaseFirestore.instance.collection('users');
  final _authentication = FirebaseAuth.instance;

  //we are gonna get data from cloud firestore
  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snapshot = await _userReference.doc(uid).get();
      return snapshot.data();
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential userCredential =
          await _authentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        ClientUser clientUser = ClientUser(
          username: username.trim(),
          email: email.trim(),
          uid: userCredential.user!.uid,
        );
        await _userReference
            .doc(userCredential.user!.uid)
            .set(clientUser.toMap());
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).setUser(clientUser);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential userCredential =
          await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).setUser(
          ClientUser.fromMap(
            await getCurrentUser(userCredential.user!.uid) ?? {},
          ),
        );
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }
}
