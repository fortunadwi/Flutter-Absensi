// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

RxBool isLoading = false.obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<DocumentSnapshot<Map<String, dynamic>>> StreamRole() async* {
  String uid = auth.currentUser!.uid;

  yield* firestore.collection("mahasiswa").doc(uid).snapshots();
}
