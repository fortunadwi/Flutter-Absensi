// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

RxBool isLoading = true.obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
  String uid = auth.currentUser!.uid;
  yield* firestore.collection("mahasiswa").doc(uid).snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> streamLastAbsensi() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore
      .collection("mahasiswa")
      .doc(uid)
      .collection("absensi")
      .orderBy("date", descending: true)
      .limitToLast(5)
      .snapshots();
}

Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayAbsensi() async* {
  String uid = auth.currentUser!.uid;
  String todayID = DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

  yield* firestore
      .collection("mahasiswa")
      .doc(uid)
      .collection("absensi")
      .doc(todayID)
      .snapshots();
}
