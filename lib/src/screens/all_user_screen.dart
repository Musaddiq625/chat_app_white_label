//
// import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
// import 'package:chat_app_white_label/src/utils/navigation_util.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../main.dart';
// import '../constants/color_constants.dart';
// import '../models/usert_model.dart';
// import '../utils/service/firbase_service.dart';
//
//
// class AllUsersScreen extends StatefulWidget {
//   const AllUsersScreen({super.key});
//
//   @override
//   State<AllUsersScreen> createState() => _AllUsersScreenState();
// }
//
// class _AllUsersScreenState extends State<AllUsersScreen> {
//   // late AppCubit appCubit = BlocProvider.of<AppCubit>(context);
//   FirebaseService firebaseService = getIt<FirebaseService>();
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return FutureBuilder<List<Map<String, dynamic>>>(
//         future:  FirebaseUtils.getMatchingContactsOnce(),
//         builder: (context, snapshot) {
//           // if (snapshot.hasError) {
//           //   return const Center(child: Text('Error fetching chats '));
//           // }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//
//           final users =
//               snapshot.data?.map((doc) => UserModel.fromJson(doc)).toList();
//           print("Matched Contacts ${users}");
//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: ColorConstants.greenMain,
//               title: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       size: 28,
//                     ),
//                     color: ColorConstants.white,
//                   ),
//                   const Text(
//                     'Select Contacts',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.search,
//                     size: 28,
//                   ),
//                   color: ColorConstants.white,
//                 ),
//                 IconButton(
//                   onPressed: () {NavigationUtil.pop(context);},
//                   icon: const Icon(
//                     Icons.more_vert_rounded,
//                     size: 28,
//                   ),
//                   color: ColorConstants.white,
//                 ),
//               ],
//               // bottom: AppBar(
//               //   automaticallyImplyLeading: false,
//               //   backgroundColor: ColorConstants.greenMain,
//               //   leading: Icon(
//               //     Icons.camera_alt_rounded,
//               //     color: Colors.white.withOpacity(0.5),
//               //     size: 28,
//               //   ),
//               //   actions: [
//               //     Container(
//               //       width: 80,
//               //       decoration: const BoxDecoration(
//               //         border: Border(
//               //           bottom: BorderSide(color: Colors.white, width: 5),
//               //         ),
//               //       ),
//               //       child: Column(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Padding(
//               //             padding: const EdgeInsets.all(8),
//               //             child: GestureDetector(
//               //               onTap: () {},
//               //               child: const Text(
//               //                 'CHATS',
//               //                 style: TextStyle(
//               //                   color: Colors.white,
//               //                   fontSize: 18,
//               //                 ),
//               //               ),
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //     Container(
//               //       width: 115,
//               //       decoration: const BoxDecoration(
//               //         border: Border(
//               //           bottom: BorderSide(color: Colors.transparent, width: 5),
//               //         ),
//               //       ),
//               //       child: Column(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Padding(
//               //             padding: const EdgeInsets.all(8),
//               //             child: GestureDetector(
//               //               onTap: () {
//               //                 NavigationUtil.push(
//               //                     context, RouteConstants.statusScreen);
//               //               },
//               //               child: Text(
//               //                 'STATUS',
//               //                 style: TextStyle(
//               //                   color: Colors.white.withOpacity(0.5),
//               //                   fontSize: 18,
//               //                 ),
//               //               ),
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //     Container(
//               //       width: 115,
//               //       decoration: const BoxDecoration(
//               //         border: Border(
//               //           bottom: BorderSide(color: Colors.transparent, width: 5),
//               //         ),
//               //       ),
//               //       child: Column(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Padding(
//               //             padding: const EdgeInsets.all(8),
//               //             child: GestureDetector(
//               //               onTap: () {
//               //                 NavigationUtil.push(
//               //                     context, RouteConstants.callScreen);
//               //               },
//               //               child: Text(
//               //                 'CALLS',
//               //                 style: TextStyle(
//               //                   color: Colors.white.withOpacity(0.5),
//               //                   fontSize: 18,
//               //                 ),
//               //               ),
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ),
//             // floatingActionButton: SizedBox(
//             //   width: 70,
//             //   height: 70,
//             //   child: FittedBox(
//             //     child: FloatingActionButton(
//             //       onPressed: () {NavigationUtil.push(context, RouteConstants.allUserScreen);},
//             //       backgroundColor: ColorConstants.green,
//             //       child: const Icon(
//             //         Icons.message,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             body: users == null || users.isEmpty
//                 ? const Center(child: Text('No Contacts available'))
//                 : ListView.builder(
//                     padding: const EdgeInsets.only(top: 7),
//                     itemBuilder: (context, index) {
//                       final UserModel user = users[index];
//                       print("user subname ${user.subName}");
//                       return UserTileComponent(
//                         name: user.name ?? "",
//                         image: user.image ?? "",
//                         message: user.about ?? "",
//                         subName: user.subName ?? "",
//                       );
//                     },
//                     itemCount: users.length //data.chat.length
//                     ),
//           );
//         });
//   }
// }
