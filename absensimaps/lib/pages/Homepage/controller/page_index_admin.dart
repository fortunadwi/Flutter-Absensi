// ignore_for_file: implementation_imports, use_key_in_widget_constructors, must_be_immutable, avoid_print, unused_import, await_only_futures, prefer_is_empty

import 'package:absensimaps/pages/Homepage/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_device_locale/flutter_device_locale.dart';

class PageIndexController extends StatelessWidget {
  RxBool isLoading = true.obs;
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      // case 1:
      //   print("Absensi");

      //   Map<String, dynamic> dataResponse = await determinePosition();
      //   if (dataResponse["error"] != true) {
      //     Position position = dataResponse["position"];

      //     List<Placemark> placemarks = await placemarkFromCoordinates(
      //         position.latitude, position.longitude);

      //     String address =
      //         "${placemarks[0].name} , ${placemarks[0].subLocality} , ${placemarks[0].locality}";
      //     await updatePosition(position, address);

      //     // Cek Distance Jarak Antara 2 Koordinat
      //     double distance = Geolocator.distanceBetween(
      //         -6.1930289, 106.5668906, position.latitude, position.longitude);

      //     // Absen
      //     await absensi(position, address, distance);

      //     // Get.snackbar("Sukses", "Berhasil Absen");
      //   } else {
      //     Get.snackbar("Terjadi Kesalahan", dataResponse["message"]);
      //   }
      //   break;

      case 1:
        pageIndex.value = i;
        Get.offAllNamed('/profilPage');
        print("Ini Page Profile");
        break;

      default:
        Get.offAllNamed('/pageAdmin');
        pageIndex.value = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> absensi(
      Position position, String address, double distance) async {
    //
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colAbsensi =
        await firestore.collection("mahasiswa").doc(uid).collection("absensi");

    QuerySnapshot<Map<String, dynamic>> snapAbsensi = await colAbsensi.get();

    DateTime now = DateTime.now();
    String todayDocID = DateFormat.yMd().format(now).replaceAll("/", "-");

    String status = "Di Luar Area";

    if (distance <= 300) {
      // Di Dalam Area
      status = "Di Dalam Area";
      if (snapAbsensi.docs.length == 0) {
        // Belum Pernah Absen & Set Absen Masuk Pertama Kali
        await Get.defaultDialog(
          title: "Validasi Absensi",
          middleText: "Apakah Kamu Ingin Absen Masuk Hari Ini?",
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await colAbsensi.doc(todayDocID).set({
                  "date": now.toIso8601String(),
                  "Masuk": {
                    "date": now.toIso8601String(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "status": status,
                    "distance": distance,
                  }
                });
                Get.back();
                Get.snackbar("Sukses", "Berhasil Absen Masuk");
              },
              child: const Text("Yes"),
            )
          ],
        );
      } else {
        // Sudah Pernah Absen -> Cek Hari Ini Apakah Sudah Absen Atau Belum
        DocumentSnapshot<Map<String, dynamic>> todayDoc =
            await colAbsensi.doc(todayDocID).get();

        if (todayDoc.exists == true) {
          // Tinggal Absen Keluar Atau Sudah Absen Masuk & Keluar
          Map<String, dynamic>? dataAbsensiToday = todayDoc.data();
          if (dataAbsensiToday?["Keluar"] != null) {
            //Sudah Absen Masuk dan Keluar
            Get.snackbar("Warning", "Kamu Telah Absen Masuk & Keluar Hari Ini");
          } else {
            // Absen Keluar
            await Get.defaultDialog(
              title: "Validasi Absensi",
              middleText: "Apakah Kamu Ingin Absen Keluar Hari Ini?",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await colAbsensi.doc(todayDocID).update({
                      "Keluar": {
                        "date": now.toIso8601String(),
                        "lat": position.latitude,
                        "long": position.longitude,
                        "address": address,
                        "status": status,
                        "distance": distance,
                      }
                    });
                    Get.back();
                    Get.snackbar("Sukses", "Berhasil Absen Keluar");
                  },
                  child: const Text("Yes"),
                )
              ],
            );
          }
        } else {
          // Absen Masuk
          await Get.defaultDialog(
            title: "Validasi Absensi",
            middleText: "Apakah Kamu Ingin Absen Masuk Hari Ini?",
            actions: [
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Absen Masuk
                  await colAbsensi.doc(todayDocID).set({
                    "date": now.toIso8601String(),
                    "Masuk": {
                      "date": now.toIso8601String(),
                      "lat": position.latitude,
                      "long": position.longitude,
                      "address": address,
                      "status": status,
                      "distance": distance,
                    }
                  });
                  Get.back();
                  Get.snackbar("Sukses", "Berhasil Absen Masuk");
                },
                child: const Text("Yes"),
              )
            ],
          );
        }
      }
    } else {
      // Di Luar Area
      Get.snackbar(
          "Warning", "Kamu Berada Di Luar Jangkauan Radius Untuk Absen");
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    //
    String uid = await auth.currentUser!.uid;

    await firestore.collection("mahasiswa").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        "message": "Tidak Dapat Mengambil GPS Dari Device Ini",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message": "Izin Menggunakan GPS Ditolak",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // Jika Belum Menyalakan Akses Lokasi
      return {
        "message": "Kamu Belum Menyalakan Akses Lokasi Pada Perangkat",
        "error": true,
      };
      // Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Berhasil Mendapatkan Posisi Device",
      "error": false,
    };
  }
}
