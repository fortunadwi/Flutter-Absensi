// ignore_for_file: file_names
// // ignore_for_file: unused_local_variable, prefer_const_constructors_in_immutables, file_names

// import 'package:absensimaps/pages/Sidebar%20Profile/Controller%20Profile/controller_profile.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ListTiles extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final Widget leading;

//   ListTiles({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.leading,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//       stream: streamUser(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {}
//         if (snapshot.hasData) {
//           Map<String, dynamic> user = snapshot.data!.data()!;
//           return ListView(
//             padding: const EdgeInsets.all(20),
//             children: [
//               ListTiles(title: title, subtitle: subtitle, leading: leading),
//             ],
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     ));
//   }
// }
