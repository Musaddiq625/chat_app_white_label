// import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
// import 'package:chat_app_white_label/src/components/toast_component.dart';
// import 'package:chat_app_white_label/src/constants/color_constants.dart';
// import 'package:chat_app_white_label/src/constants/route_constants.dart';
// import 'package:chat_app_white_label/src/models/contacts_model.dart';
// import 'package:chat_app_white_label/src/utils/chats_utils.dart';
// import 'package:chat_app_white_label/src/utils/navigation_util.dart';
// import 'package:flutter/material.dart';

// class SelectContactsScreen extends StatefulWidget {
//   final SelectContactsScreenArg selectContactsScreenArg;
//   const SelectContactsScreen(
//       {super.key, required this.selectContactsScreenArg});

//   @override
//   State<SelectContactsScreen> createState() => _SelectContactsScreenState();
// }

// class _SelectContactsScreenState extends State<SelectContactsScreen> {
//   bool isEditing = false;
//   List selectedContacts = [];
//   @override
//   void initState() {
//     super.initState();
//     if ((widget.selectContactsScreenArg.selectedContacts ?? []).isNotEmpty) {
//       selectedContacts = widget.selectContactsScreenArg.selectedContacts!;
//       isEditing = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorConstants.greenMain,
//         leading: IconButton(
//           onPressed: () => NavigationUtil.pop(context),
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 28,
//           ),
//           color: ColorConstants.white,
//         ),
//         title: const Text(
//           'Select Contacts to Add',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: widget.selectContactsScreenArg.contactsList.isNotEmpty
//           ? ListView.builder(
//               itemCount: widget.selectContactsScreenArg.contactsList.length,
//               padding: const EdgeInsets.only(top: 7),
//               itemBuilder: (context, index) {
//                 return ContactTileComponent(
//                   localName: widget.selectContactsScreenArg.contactsList[index]
//                           .localName ??
//                       '',
//                   chatUser: widget
//                       .selectContactsScreenArg.contactsList[index].firebaseData,
//                   isSelected: selectedContacts.any((contact) =>
//                       contact ==
//                       widget.selectContactsScreenArg.contactsList[index]
//                           .phoneNumber),
//                   onContactTap: () {
//                     if (selectedContacts.any((contact) =>
//                         contact ==
//                         widget.selectContactsScreenArg.contactsList[index]
//                             .phoneNumber)) {
//                       selectedContacts.removeWhere((contact) =>
//                           contact ==
//                           widget.selectContactsScreenArg.contactsList[index]
//                               .phoneNumber);
//                     } else {
//                       selectedContacts.add(widget.selectContactsScreenArg
//                           .contactsList[index].phoneNumber);
//                     }
//                     setState(() {});
//                   },
//                 );
//               },
//             )
//           : const Center(
//               child: Text("No Contacts Available !"),
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: ColorConstants.green,
//         child: const Icon(
//           Icons.done,
//           color: Colors.white,
//         ),
//         onPressed: () async {
//           if (selectedContacts.isNotEmpty) {
//             if (isEditing == false) {
//               NavigationUtil.push(context, RouteConstants.createGroupScreen,
//                   args: selectedContacts);
//             } else {
//               await ChatUtils.addMoreMembersToGroupChat(
//                 widget.selectContactsScreenArg.groupChatId ?? "",
//                 widget.selectContactsScreenArg.selectedContacts ?? [],
//               );
//               NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
//             }
//           } else {
//             ToastComponent.showToast('Please select atleast one contact',
//                 context: context);
//           }
//         },
//       ),
//     );
//   }
// }

// class SelectContactsScreenArg {
//   final List<ContactModel> contactsList;
//   final List? selectedContacts;
//   final String? groupChatId;
//   SelectContactsScreenArg(
//       {required this.contactsList, this.selectedContacts, this.groupChatId});
// }
