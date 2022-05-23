// import 'package:etra_flutter/services/session.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:riverpod/riverpod.dart';
//
//
// class UserInput {
//   final UserName;
//   final Email;
//   final UserPhone;
//   final UserBirthDate;
//
//   USerInput(this.UserName, this.Email, this.UserPhone, this.UserBirthDate);
// }
//
//
//
//
//
// class PromptList extends StatefulWidget {
//   const PromptList({Key? key}) : super(key: key);
//
//   @override
//   _PromptListState createState() => _PromptListState();
// }
//
// class _PromptListState extends State<PromptList> {
//   @override
//   Widget build(BuildContext context) {
//     UserNotifier userNotifier = Provider. of<userNotifier> (context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Real time list'),
//       ),
//       body: Container(
//         child: ListView.builder(
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 elevation: 10,
//                 child: Column(
//                   children: [
//                     Text(Consumer<userNotifier>(notifier.UserName)),
//                   ],
//                 ),
//               );
//             }
//         ),
//       ),
//     );
//   }
// }
