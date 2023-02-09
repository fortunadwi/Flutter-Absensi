// // ignore_for_file: avoid_print, unused_element

// import 'package:absensimaps/pages/page_user.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_login/flutter_login.dart';

// import '../providers/auth.dart';

// const users = {
//   'coba@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
// };

// class LoginFunct extends StatefulWidget {
//   const LoginFunct({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginFunctState createState() => _LoginFunctState();
// }

// class _LoginFunctState extends State<LoginFunct> {
//   Duration get loginTime => const Duration(milliseconds: 2250);

//   Future<String> _authUserSignup(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       // if (!users.containsKey(data.name)) {
//       //   return 'Username not exists';
//       // }
//       // if (users[data.name] != data.password) {
//       //   return 'Password does not match';
//       // }
//       Provider.of<Auth>(context, listen: false)
//           .signup(data.name, data.password);
//       return '';
//     });
//   }

//   Future<String> _authUserLogin(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       // if (!users.containsKey(data.name)) {
//       //   return 'Username not exists';
//       // }
//       // if (users[data.name] != data.password) {
//       //   return 'Password does not match';
//       // }
//       Provider.of<Auth>(context, listen: false).login(data.name, data.password);
//       return '';
//     });
//   }

//   // SignUp Form
//   Future<String> _authUser(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(data.name)) {
//         return 'Email not exists';
//       }
//       if (users[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return '';
//     });
//   }

//   Future<String> _recoverPassword(String name) {
//     print('Name: $name');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(name)) {
//         return 'Username Not Exist';
//       }
//       return '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'ABSENSI',
//       // logo: 'assets/images/logo.png',
//       onLogin: _authUserLogin,
//       onSignup: _authUserSignup,
//       // loginAfterSignUp: true,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => const PageUser(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }
