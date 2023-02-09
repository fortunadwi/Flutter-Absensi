// import 'package:absensimaps/pages/login.page.dart';
// import 'package:absensimaps/pages/page_user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthPageReal extends StatelessWidget {
//   const AuthPageReal({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const PageUser();
//           } else {
//             return const LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
