import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/contacts_model.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class SelectContactsScreen extends StatefulWidget {
  final List<ContactModel> contactsList;
  const SelectContactsScreen({super.key, required this.contactsList});

  @override
  State<SelectContactsScreen> createState() => _SelectContactsScreenState();
}

class _SelectContactsScreenState extends State<SelectContactsScreen> {
  List selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.greenMain,
        leading: IconButton(
          onPressed: () => NavigationUtil.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
          color: ColorConstants.white,
        ),
        title: const Text(
          'Select Contacts to Add',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: widget.contactsList.isNotEmpty
          ? ListView.builder(
              itemCount: widget.contactsList.length,
              padding: const EdgeInsets.only(top: 7),
              itemBuilder: (context, index) {
                return ContactTileComponent(
                  localName: widget.contactsList[index].localName ?? '',
                  chatUser: widget.contactsList[index].firebaseData,
                  isSelected: selectedContacts.any((contact) =>
                      contact == widget.contactsList[index].phoneNumber),
                  onContactTap: () {
                    if (selectedContacts.any((contact) =>
                        contact == widget.contactsList[index].phoneNumber)) {
                      selectedContacts.removeWhere((contact) =>
                          contact == widget.contactsList[index].phoneNumber);
                    } else {
                      selectedContacts
                          .add(widget.contactsList[index].phoneNumber);
                    }
                    setState(() {});
                  },
                );
              },
            )
          : const Center(
              child: Text("No Contacts Available !"),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.green,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
        onPressed: () {
          if (selectedContacts.isNotEmpty) {
            NavigationUtil.push(context, RouteConstants.createGroupScreen,
                args: selectedContacts);
          } else {
            ToastComponent.showToast('Please select atleast one contact',
                context: context);
          }
        },
      ),
    );
  }
}
