import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/components/about_event_component.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contacts_card_component.dart';
import 'package:chat_app_white_label/src/components/creatorQuestionAnswers.dart';
import 'package:chat_app_white_label/src/components/icon_component.dart';
import 'package:chat_app_white_label/src/components/icons_button_component.dart';
import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/joinBottomSheetComponent.dart';
import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/tag_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/text_field_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewGroupScreen extends StatefulWidget {
  const ViewGroupScreen({super.key});

  @override
  State<ViewGroupScreen> createState() => _ViewGroupScreenState();
}

class _ViewGroupScreenState extends State<ViewGroupScreen> {
  final TextEditingController _messageController = TextEditingController();
  final String invitedBy = "Aylna";
  final String groupName = "Aylna's Wonderful Group";
  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  double radius = 30;
  final String _fullText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  bool _showFullText = false;
  bool groupMember = false;

  final List<ImageProvider> images = [
    const CachedNetworkImageProvider(
        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
    const CachedNetworkImageProvider(
        "https://i.pinimg.com/236x/85/59/09/855909df65727e5c7ba5e11a8c45849a.jpg"),
    const CachedNetworkImageProvider(
        "https://wallpapers.com/images/hd/instagram-profile-pictures-87zu6awgibysq1ub.jpg"),
    // Replace with your asset path
    // Add more image providers as needed
  ];

  final List<String> questions = [
    "Hello Question 1",
    "Hello Question 2",
    "Hello Question 3",
  ];


  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "","00112233455"),
    ContactModel('Albert Ebert', 'Manager', "","45612378123"),
    ContactModel('Json Ebert', 'Tester', "","03323333333"),
    ContactModel('Mack', 'Intern', "","03312233445"),
    ContactModel('Julia', 'Developer', "","88552233644"),
    ContactModel('Rose', 'Human Resource', "","55366114532"),
    ContactModel('Frank', 'xyz', "","25651412344"),
    ContactModel('Taylor', 'Test', "","5511772266"),
  ];

  TextEditingController searchControllerConnections = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UIScaffold(
      // appBar: AppBarComponent(""),
      removeSafeAreaPadding: false,
      bgColor: ColorConstants.backgroundColor,
      widget: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          color: themeCubit.backgroundColor,
          child: Column(
            children: [_eventWidget(), _members()],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: (!groupMember)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWithIconComponent(
                    iconColor: ColorConstants.white,
                    btnText: '  ${StringConstants.decline}',
                    btnTextColor: ColorConstants.white,
                    icon: Icons.cancel,
                    widthSpace: 30,
                    bgcolor: ColorConstants.blackLight,
                    // btnTextColor: themeCubit.textColor,
                    onPressed: () {
                      // _showJoinBottomSheet();
                    },
                  ),
                  ButtonWithIconComponent(
                    btnText: '  ${StringConstants.accept}',
                    icon: Icons.check_circle,
                    bgcolor: themeCubit.primaryColor,
                    widthSpace: 30,
                    // btnTextColor: themeCubit.textColor,
                    onPressed: () {
                      JoinBottomSheet.showJoinBottomSheet(
                          context,
                          _messageController,
                          "",
                          "",
                          "",
                          "",
                          "Property networking event",
                          "Group",
                          "ABC",
                          "",
                          // questions: questions
                      );
                      // _showJoinBottomSheet();
                    },
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconComponent(
                      iconData: Icons.favorite,
                      backgroundColor: ColorConstants.blackLight,
                      circleSize: 40,
                      iconSize: 25,
                      onTap: () {
                        // _shareEventBottomSheet();
                      }),
                  SizedBoxConstants.sizedBoxTenW(),
                  IconComponent(
                    // iconData: Icons.menu,
                    svgData: AssetConstants.share,
                    backgroundColor: ColorConstants.blackLight,
                    circleSize: 40,
                    iconSize: 20,
                    // onTap: _showMoreBottomSheet,
                  ),
                  SizedBoxConstants.sizedBoxTenW(),
                  IconComponent(
                    // iconData: Icons.menu,
                    svgData: AssetConstants.more,
                    backgroundColor: ColorConstants.blackLight,
                    circleSize: 40,
                    iconSize: 6,
                    // onTap: _showMoreBottomSheet,
                  ),
                  Spacer(),
                  if (groupMember)
                    ButtonWithIconComponent(
                      btnText: '  ${StringConstants.chat}',
                      svgData: AssetConstants.message,
                      bgcolor: themeCubit.primaryColor,
                      widthSpace: 30,
                      // btnTextColor: themeCubit.textColor,
                      onPressed: () {
                        // _showJoinBottomSheet();
                      },
                    ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _eventWidget() {
    return Stack(children: [
      Image.network(
        "https://img.freepik.com/free-photo/mesmerizing-view-high-buildings-skyscrapers-with-calm-ocean_181624-14996.jpg",
        fit: BoxFit.fill,
        width: double.infinity,
        height: 500,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              "",
              iconBgColor: ColorConstants.iconBg,
            ),
            SizedBoxConstants.sizedBoxEightyH(),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15, left: 10, bottom: 80),
            //   child: IconComponent(
            //     iconData: Icons.arrow_back_ios_new_outlined,
            //     borderColor: Colors.transparent,
            //     backgroundColor: ColorConstants.iconBg,
            //     iconColor: ColorConstants.white,
            //     iconSize: 20,
            //     circleSize: 40,
            //     onTap: () => Navigator.pop(context),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileImageComponent(
                    url: "",
                    size: 40,
                  ),
                  SizedBoxConstants.sizedBoxEightW(),
                  TextComponent(
                    "${StringConstants.invitedBy + invitedBy}",
                    style: FontStylesConstants.style16(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextComponent(groupName,
                  maxLines: 6,
                  style:
                      FontStylesConstants.style38(color: ColorConstants.white)),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  IconComponent(
                    iconData: Icons.lock,
                    backgroundColor: ColorConstants.transparent,
                    customIconText: StringConstants.private,
                    circleSize: 60,
                    circleHeight: 35,
                    iconSize: 20,
                  ),
                ],
              ),
            ),
            SizedBoxConstants.sizedBoxTenH(),
            Container(
              width: AppConstants.responsiveWidth(context, percentage: 100),
              //MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
              decoration: BoxDecoration(
                color: ColorConstants.darkBackgrounddColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ContactCard(
                  name: "Jesse",
                  url: "",
                  title: "Group Creator",
                  showShareIcon: false,
                  showDivider: false,
                  imageSize: 40,
                ),
              ),
            ),
            _aboutTheGroup(),
            if (groupMember) SizedBoxConstants.sizedBoxTenH(),
            if (groupMember)
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: AppConstants.responsiveWidth(context, percentage: 90),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.btnGradientColor,
                      const Color.fromARGB(255, 220, 210, 210)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ButtonComponent(
                    bgcolor: ColorConstants.transparent,
                    textColor: ColorConstants.black,
                    buttonText: StringConstants.inviteFriends,
                    onPressed: () {}),
              ),
            if (groupMember) SizedBoxConstants.sizedBoxTenH(),
            // _members(),
          ],
        ),
      ),
    ]);
  }

  Widget _aboutTheGroup() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(StringConstants.aboutTheGroup,
                    style: FontStylesConstants.style18(
                        color: themeCubit.primaryColor)),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showFullText = !_showFullText;
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: _showFullText
                              ? _fullText
                              : (_fullText.length > 150
                                      ? _fullText.substring(0, 150)
                                      : _fullText) ??
                                  "No description available",
                          style: TextStyle(color: themeCubit.textColor),
                        ),
                        if (_fullText.length > 150)
                          TextSpan(
                            text: _showFullText
                                ? ' ${StringConstants.showLess}'
                                : ' ...${StringConstants.readMore}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeCubit.textColor),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          DividerCosntants.divider1,
          // SizedBoxConstants.sizedBoxTenH(),
          Container(
            // padding: const EdgeInsets.only(left: 16, bottom: 8, right: 20),
            child: Column(
              children: [
                // AboutEventComponent(
                //   name: "1456 ${StringConstants.participants}",
                //   detail: "Elena, Ilsa and more",
                //   icon: AssetConstants.happy,
                //   showPersonIcon: true,
                //   selectedImages: images,
                // ),
                // AboutEventComponent(
                //   name: StringConstants.flexibleDate,
                //   detail: StringConstants.dateWillbeDecidelater,
                //   icon: AssetConstants.calendar,
                // ),
                AboutEventComponent(
                  divider: false,
                  name: "Manchester",
                  detail: StringConstants.exactLocationAfterJoining,
                  icon: AssetConstants.marker,
                ),
                // if (ticketRequired == true)
                // AboutEventComponent(
                //   name: "SR 150",
                //   detail: StringConstants.ticketrequired,
                //   icon: AssetConstants.ticket,
                // ),
                // AboutEventComponent(
                //   divider: false,
                //   name: StringConstants.capacityOf,
                //   detail: StringConstants.limitedGuests,
                //   icon: AssetConstants.tag,
                // ),
                SizedBoxConstants.sizedBoxTenH()
              ],
            ),
          ),
        ]));
  }

  Widget _members() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: themeCubit.darkBackgroundColor,
        elevation: 0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 18),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: FontConstants.fontProtestStrike,
                        fontSize: 18,
                        color: themeCubit.primaryColor),
                    children: <TextSpan>[
                      const TextSpan(text: "${StringConstants.members}  "),
                      TextSpan(
                        text: contacts.length.toString(),
                        style: TextStyle(
                            color: ColorConstants.lightGray.withOpacity(0.5)),
                      ),
                    ],
                  ),
                )),
            SizedBoxConstants.sizedBoxThirtyH(),
            Row(
              children: [
                Container(
                    width:
                        AppConstants.responsiveWidth(context, percentage: 66),
                    child: const ContactCard(
                      name: "Jesse",
                      url: "",
                      title: "Graphic Designer",
                      showShareIcon: false,
                      showDivider: false,
                      imageSize: 45,
                    )),
                TagComponent(
                  width: AppConstants.responsiveWidth(context, percentage: 22),
                  customTextColor: themeCubit.backgroundColor,
                  backgroundColor: ColorConstants.primaryColor,
                  iconColor: themeCubit.primaryColor,
                  customIconText: StringConstants.creator,
                ),
                // Container(
                //
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, top: 3, bottom: 3),
                //   decoration: BoxDecoration(
                //     color: ColorConstants.primaryColor,
                //     borderRadius: BorderRadius.all(Radius.circular(20)),
                //     // color: themeCubit.darkBackgroundColor,
                //   ),
                //   child: TextComponent(StringConstants.creator,
                //       textAlign: TextAlign.right),
                // ),
              ],
            ),
            DividerCosntants.divider1,
            ...List.generate(
                contacts.length,
                (index) => ContactCard(
                    imageSize: 45,
                    name: contacts[index].name,
                    title: contacts[index].title,
                    url: contacts[index].url,
                    // contact: contacts[index],
                    showShareIcon: false)),
            SizedBoxConstants.sizedBoxSixtyH(),
          ],
        ),
      ),
    );
  }

  _showJoinBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            // color: themeCubit.darkBackgroundColor,
          ),
          // padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(StringConstants.join,
                            style: FontStylesConstants.style18(
                                color: themeCubit.primaryColor)),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: IconComponent(
                            iconData: Icons.close,
                            borderColor: Colors.transparent,
                            iconColor: themeCubit.textColor,
                            circleSize: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextComponent(groupName,
                              maxLines: 3,
                              style: FontStylesConstants.style28(
                                  color: ColorConstants.white)),
                        ),
                        ImageComponent(
                            height: 100,
                            width: 100,
                            isAsset: true,
                            imgUrl: AssetConstants.ticketWithCircle,
                            imgProviderCallback: (imgProviderCallback) {}),
                      ],
                    ),
                    TextComponent(StringConstants.group,
                        style: FontStylesConstants.style14(
                            color: ColorConstants.white)),
                    SizedBoxConstants.sizedBoxTwentyH(),
                  ],
                ),
              ),
              DividerCosntants.divider1,
              _questionsFromCreatorComponent(),
              DividerCosntants.divider1,
              _messageComponent(),
              DividerCosntants.divider1,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      StringConstants.somethingToKnow,
                      style: TextStyle(
                          color: themeCubit.primaryColor,
                          fontFamily: FontConstants.fontProtestStrike,
                          fontSize: 18),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.chatMsg,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBoxConstants.sizedBoxTenH(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 35,
                          AssetConstants.clock,
                        ),
                        // ProfileImageComponent(
                        //   url: "",
                        //   size: 30,
                        // ),
                        SizedBoxConstants.sizedBoxEighteenW(),
                        TextComponent(
                          StringConstants.whenYouJoinYoureInTheGame,
                          style: TextStyle(color: themeCubit.textColor),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    SizedBoxConstants.sizedBoxForthyH(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ButtonComponent(
                  buttonText: StringConstants.join,
                  textColor: themeCubit.backgroundColor,
                  onPressed: () {
                    NavigationUtil.pop(context);
                    _shareGroupBottomSheet();
                  },
                  bgcolor: themeCubit.primaryColor,
                ),
              ),
              SizedBoxConstants.sizedBoxTwentyH()
            ],
          ),
        ));
  }

  _messageComponent() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              ProfileImageComponent(
                url: "",
                size: 30,
              ),
              SizedBoxConstants.sizedBoxTenW(),
              TextComponent(
                "Message for Raul",
                style: FontStylesConstants.style18(
                    color: ColorConstants.primaryColor),
              ),
            ],
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextComponent(
            StringConstants.doYouHaveQuestion,
            style: FontStylesConstants.style14(color: ColorConstants.white),
            maxLines: 4,
          ),
          SizedBoxConstants.sizedBoxTenH(),
          TextFieldComponent(
            _messageController,
            filled: true,
            textFieldFontSize: 12,
            hintText: StringConstants.typeYourMessage,
            fieldColor: ColorConstants.lightGray.withOpacity(0.5),
            maxLines: 4,
            minLines: 4,
          ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  _questionsFromCreatorComponent() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            StringConstants.questionsFromCreator,
            style:
                FontStylesConstants.style18(color: ColorConstants.primaryColor),
          ),
          SizedBoxConstants.sizedBoxTenH(),
          Column(
            children: [
              CreatorQuestionsAnswer(questions: [],
                  // questions: questions
              ),
            ],
          ),
          // TextComponent(
          //   StringConstants.doYouHaveQuestion,
          //   style: FontStylesConstants.style14(color: ColorConstants.white),
          //   maxLines: 4,
          // ),
          // SizedBoxConstants.sizedBoxTenH(),
          // TextFieldComponent(
          //   _messageController,
          //   filled: true,
          //   textFieldFontSize: 12,
          //   hintText: StringConstants.typeYourAnswer,
          //   fieldColor: ColorConstants.lightGray.withOpacity(0.5),
          //   maxLines: 4,
          // ),
          SizedBoxConstants.sizedBoxTenH()
        ],
      ),
    );
  }

  _shareGroupBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: true,
        isShowHeader: false,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: themeCubit.darkBackgroundColor,
          ),
          constraints: const BoxConstraints(maxHeight: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => NavigationUtil.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0, top: 15),
                      child: IconComponent(
                        iconData: Icons.close,
                        borderColor: Colors.transparent,
                        iconColor: themeCubit.textColor,
                        circleSize: 10,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Image.asset(
                    AssetConstants.confetti,
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    padding: const EdgeInsets.only(top: 10),
                    child: TextComponent(
                      StringConstants.joinTheGroupSuccessfully,
                      maxLines: 6,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: FontConstants.fontProtestStrike,
                          color: themeCubit.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width:
                        AppConstants.responsiveWidth(context, percentage: 60),
                    child: TextComponent(
                      StringConstants.inviteYourFriend,
                      maxLines: 6,
                      style:
                          TextStyle(fontSize: 15, color: themeCubit.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconComponent(
                    // iconData: Icons.link,
                    svgData: AssetConstants.copyLink,
                    borderColor: Colors.transparent,
                    backgroundColor: themeCubit.primaryColor,
                    iconColor: ColorConstants.black,
                    circleSize: 60,
                    customText: StringConstants.copyLink,
                    customTextColor: themeCubit.textColor,
                  ),
                  IconComponent(
                    iconData: Icons.facebook,
                    borderColor: Colors.transparent,
                    backgroundColor: ColorConstants.blue,
                    circleSize: 60,
                    iconSize: 30,
                    customText: StringConstants.facebook,
                    customTextColor: themeCubit.textColor,
                  ),
                  // IconComponent(
                  //   svgDataCheck: false,
                  //   svgData: AssetConstants.instagram,
                  //   backgroundColor: Colors.transparent,
                  //   borderColor: Colors.transparent,
                  //   circleSize: 60,
                  //   customText: StringConstants.instagram,
                  //   customTextColor: themeCubit.textColor,
                  //   iconSize: 60,
                  // ),
                  Column(
                    children: [
                      ImageComponent(
                        height: 60,
                        width: 60,
                        imgUrl: AssetConstants.instagram,
                        imgProviderCallback: (imageProvider) {},
                      ),
                      SizedBoxConstants.sizedBoxTenH(),
                      TextComponent(
                        StringConstants.instagram,
                        style: FontStylesConstants.style12(
                            color: ColorConstants.white),
                      )
                    ],
                  ),
                  IconComponent(
                    svgData: AssetConstants.share,
                    iconColor: ColorConstants.black,
                    borderColor: Colors.transparent,
                    // backgroundColor:ColorConstants.transparent,
                    circleSize: 60,
                    customText: StringConstants.share,
                    customTextColor: themeCubit.textColor,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 5),
                child: TextComponent(
                  StringConstants.yourConnections,
                  style: TextStyle(
                      color: themeCubit.primaryColor,
                      fontFamily: FontConstants.fontProtestStrike,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, top: 10, bottom: 16, right: 18),
                child: SearchTextField(
                  filledColor: ColorConstants.backgroundColor.withOpacity(0.3),
                  title: "Search",
                  hintText: "Search name, postcode..",
                  onSearch: (text) {
                    // widget.viewModel.onSearchStories(text);
                  },
                  textEditingController: searchControllerConnections,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (ctx, index) {
                    return ContactCard(
                      name: contacts[index].name,
                      title: contacts[index].title,
                      url: contacts[index].url,
                      // contact: contacts[index],
                      onShareTap: () {
                        // Navigator.pop(context);
                        // _shareWithConnectionBottomSheet(
                        //     StringConstants.fireWorks, contacts[index].name);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
