import 'dart:io';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/custom_button.dart';
import 'package:chat_app_white_label/src/components/custom_text_field.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/cubit/create_group_chat_cubit.dart';
import 'package:chat_app_white_label/src/utils/loading_dialog.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/service/firbase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  final List contactsList;
  const CreateGroupScreen({super.key, required this.contactsList});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late CreateGroupChatCubit createGroupChatCubit;
  FirebaseService firebaseService = getIt<FirebaseService>();
  final groupNameController = TextEditingController();
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createGroupChatCubit = CreateGroupChatCubit(),
      child: BlocListener<CreateGroupChatCubit, CreateGroupChatState>(
        listener: (context, state) async {
          LoggerUtil.logs('login state: $state');
          if (state is CreateGroupChatLoadingState) {
            LoadingDialog.showLoadingDialog(context);
          } else if (state is CreateGroupChatSuccessState) {
            LoadingDialog.hideLoadingDialog(context);
            LoggerUtil.logs("Group Created");
            // NavigationUtil.push(context, RouteConstants.chatRoomScreen);
          } else if (state is CreateGroupChatFailureState) {
            LoadingDialog.hideLoadingDialog(context);
            ToastComponent.showToast(state.error.toString(), context: context);
          }
        },
        child: Scaffold(
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
              'Create Gorup ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 50, bottom: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: (selectedImage != null
                                ? FileImage(File(selectedImage!.path))
                                : const AssetImage(AssetConstants.group))
                            as ImageProvider,
                      ),
                      Positioned(
                          right: 5,
                          bottom: 5,
                          child: GestureDetector(
                            onTap: () {
                              if (selectedImage == null) {
                                imageSelectionOption(context);
                              } else {
                                setState(() {
                                  selectedImage = null;
                                });
                              }
                            },
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    const Color.fromARGB(255, 238, 238, 238),
                                child: Icon(
                                  selectedImage == null
                                      ? Icons.edit
                                      : Icons.cancel_outlined,
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  size: 16,
                                )),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: CustomTextField(
                      hintText: 'Group Name',
                      maxLength: 30,
                      keyboardType: TextInputType.name,
                      controller: groupNameController,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      buttonText: "Create Group",
                      onPressedFunction: () async {
                        if (groupNameController.text.isEmpty) {
                          ToastComponent.showToast(
                            'Name cannot be empty',
                            context: context,
                          );
                        } else {
                          createGroupChatCubit.createGroupChat(
                              groupNameController.text,
                              widget.contactsList,
                              selectedImage?.path);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageSelectionOption(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  try {
                    final XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      selectedImage = image;
                      setState(() {});
                      NavigationUtil.pop(context);
                    }
                  } catch (e) {
                    LoggerUtil.logs(e);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.grey,
                      ),
                      Text(
                        '   Select from Gallery',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final XFile? image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    selectedImage = image;
                    setState(() {});
                    NavigationUtil.pop(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                      Text(
                        '   Select from Camera',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
