// ignore_for_file: sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewDetailAbsensi extends StatelessWidget {
  final Map<String, dynamic> data = Get.arguments;
  ViewDetailAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Detail Absensi"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    "${DateFormat.yMMMMEEEEd().format(DateTime.parse(data['date']))}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Masuk",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "Jam : ${DateFormat.jms().format(DateTime.parse(data['Masuk']!['date']))}"),
                Text(
                    "Posisi : ${data['Masuk']!['lat']}, ${data['Masuk']!['long']}"),
                Text("Status : ${data['Masuk']!['status']}"),
                Text("Address : ${data['Masuk']!['address']}"),
                Text(
                    "Distance : ${data['Masuk']!['distance'].toString().split(".").first} Meter"),
                const SizedBox(height: 20),
                const Text(
                  "Keluar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(data['Keluar']?['date'] == null
                    ? "Jam : -"
                    : "Jam : ${DateFormat.jms().format(DateTime.parse(data['Keluar']!['date']))}"),
                Text(data['Keluar']?['lat'] == null &&
                        data['Keluar']?['long'] == null
                    ? "Posisi : -"
                    : "Posisi : ${data['Keluar']!['lat']}, ${data['Keluar']!['long']}"),
                Text(data['Keluar']?['status'] == null
                    ? "Status : -"
                    : "Status : ${data['Keluar']!['status']}"),
                Text(data['Keluar']?['distance'] == null
                    ? "Distance : -"
                    : "Distance : ${data['Keluar']!['distance'].toString().split(".").first} Meter"),
                Text(data['Keluar']?['address'] == null
                    ? "Address : -"
                    : "Address : ${data['Keluar']!['address']}"),
                const SizedBox(height: 20),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green[200],
            ),
          ),
        ],
      ),
    );
  }
}
