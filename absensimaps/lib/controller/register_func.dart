// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final emailR = TextEditingController();
final passR = TextEditingController();
final usernameR = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// User? user;

Future<void> RegisterUser() async {
  if (emailR.text.isNotEmpty &&
      passR.text.isNotEmpty &&
      usernameR.text.isNotEmpty) {
    try {
      UserCredential siswaCredential =
          await auth.createUserWithEmailAndPassword(
              email: emailR.text, password: passR.text);

      if (siswaCredential.user != null) {
        String uid = siswaCredential.user!.uid;

        final data = <String, dynamic>{
          "nama": usernameR.text,
          "email": emailR.text,
          "role": "user",
          "uid": uid,
          "nim": Random().nextInt(1000000),
          "job": "Mahasiswa",
        };
        print("Data Berhasil Dibuat");

        if (data.isNotEmpty) {
          await firestore.collection("mahasiswa").doc(uid).set(data);
          print("Data Berhasil Dibuat");
        }
      }
      Get.snackbar("Suksess", "Akun Berhasil Dibuat, Silahkan Login");
      await siswaCredential.user!.sendEmailVerification();

      Get.offNamed('/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Warning!", "Email Sudah Terdaftar",
            colorText: Colors.black);
        // Color.fromRGBO(134, 139, 247, 1)
        print("User Tidak Terdaftar");
      }
    }
  } else {
    //
    Get.snackbar("Error", "Data Tidak Boleh Kosong !");
  }
}
