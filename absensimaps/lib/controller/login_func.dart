// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
// import 'package:get/get_core/src/get_main.dart';

final emailC = TextEditingController();
final passC = TextEditingController();
final emailReset = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

void LogIn() async {
  try {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          // Navigator.pushNamed(context, 'pageAdmin');
          emailC.clear();
          passC.clear();
          Get.offNamed("/landingPage");
        } else {
          //
          Get.snackbar("Warning", "Harap Verifikasi Email Terlebih Dahulu");

          Timer(Duration(seconds: 2), () {
            Get.defaultDialog(
                title: "Warning",
                middleText:
                    "Email Anda Belum Terverifikasi, Harap Lakukan Verifikasi Terlebih Dahulu",
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      emailC.clear();
                      passC.clear();
                    },
                    child: Text("Kirim Verifikasi"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      // userCredential.user!.sendEmailVerification();
                      Get.back();
                    },
                    child: Text("Kembali"),
                  )
                ]);
          });
        }
      } else {
        //
      }
    } else {
      Get.snackbar("Warning !", "Username Atau Password Tidak Boleh Kosong");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.snackbar("Warning!", "User Tidak Terdaftar",
          colorText: Colors.white30);
      print("User Tidak Terdaftar");
    } else if (e.code == 'wrong-password') {
      Get.snackbar(
        "Warning!",
        "Password Salah",
        margin: EdgeInsets.all(19),
      );
      print("Password Salah");
    }
  }
}

void SignOut() {
  auth.signOut();
  Get.offAllNamed('/');
}

void ResetPassword() {
  //
  Get.defaultDialog(
    backgroundColor: Color.fromARGB(255, 218, 219, 239),
    buttonColor: Colors.black,
    confirmTextColor: Colors.white,
    title: "Reset Password",
    middleText:
        "Email Anda Belum Terverifikasi, Harap Lakukan Verifikasi Terlebih Dahulu",
    content: TextField(
      autocorrect: false,
      controller: emailReset,
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Input Email Anda",
        border: OutlineInputBorder(),
      ),
    ),
    actions: [
      ElevatedButton(
          onPressed: () async {
            if (emailReset.text.isNotEmpty) {
              //
              try {
                await auth.sendPasswordResetEmail(email: emailReset.text);
                Get.back();
                Get.snackbar("Success", "Silahkan Cek Email Anda");
              } on FirebaseAuthException catch (e) {
                //
                if (e.code == 'user-not-found') {
                  Get.snackbar("Error", "Email Tidak Terdaftar");
                  print("Email Tidak Terdaftar");
                  emailReset.clear();
                } else {
                  Get.back();
                  Get.snackbar("Warning", "Format Email Salah");
                  emailReset.clear();
                }
              }
            } else {
              //
              Get.back();
              Get.snackbar("Warning", "Email Wajib Diisi");
            }
          },
          child: Text("Kirim"))
    ],
  );
}
