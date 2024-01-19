// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:plan_app/src/constants/color_constants.dart';
// import 'package:plan_app/src/constants/style/font_styles_constants.dart';
// import 'package:plan_app/src/utils/component/cache_image_network_component.dart';
// import 'package:plan_app/src/utils/component/full_screen_video_Player/full_screen_video_payer.dart';
// import 'package:plan_app/src/utils/component/main_scaffold.dart';
// import 'package:plan_app/src/utils/component/text_component.dart';
// import 'package:plan_app/src/utils/navigation_util.dart';
// import 'media_view_wrapper.dart';

// class MediaViewScreen extends StatefulWidget {
//   final MediaPreviewWrapper mediaPreviewWrapper;

//   MediaViewScreen({
//     Key? key,
//     required this.mediaPreviewWrapper,
//   }) : super(key: key);

//   @override
//   State<MediaViewScreen> createState() => _MediaViewScreenState();
// }

// class _MediaViewScreenState extends State<MediaViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MainScaffold(
//       widget: _getAssetViewWidget(widget.mediaPreviewWrapper),
//     );
//   }

//   _getAssetViewWidget(MediaPreviewWrapper mediaPreviewWrapper) {
//     if (mediaPreviewWrapper.assetType == "image") {
//       return Stack(
//         alignment: Alignment.center,
//         children: [
//           File(mediaPreviewWrapper.asset ?? '').existsSync()
//               ? Center(child: Image.file(File(mediaPreviewWrapper.asset!)))
//               : Center(
//                   child: CacheImageNetworkComponent(
//                       imgUrl: mediaPreviewWrapper.asset!)),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: GestureDetector(
//                   onTap: () {
//                     NavigationUtil.pop(context);
//                   },
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: ColorConstants.grey,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.cancel,
//                         color: ColorConstants.whiteColor,
//                         size: 35,
//                       ))),
//             ),
//           )
//         ],
//       );
//     } else if (mediaPreviewWrapper.assetType == "svgImage") {
//       return Stack(
//         alignment: Alignment.center,
//         children: [
//           Center(
//             child: File(mediaPreviewWrapper.asset ?? '').existsSync()
//                 ? SvgPicture.file(File(mediaPreviewWrapper.asset!))
//                 : SvgPicture.network(mediaPreviewWrapper.asset!),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: GestureDetector(
//                   onTap: () {
//                     NavigationUtil.pop(context);
//                   },
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: ColorConstants.grey,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.cancel,
//                         color: ColorConstants.whiteColor,
//                         size: 35,
//                       ))),
//             ),
//           )
//         ],
//       );
//     } else if (mediaPreviewWrapper.assetType == "pdf") {
//       return Stack(
//         alignment: Alignment.center,
//         children: [
//           Center(
//               child: PDFView(
//             filePath: mediaPreviewWrapper.asset!,
//           )),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: GestureDetector(
//                   onTap: () {
//                     NavigationUtil.pop(context);
//                   },
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: ColorConstants.grey,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.cancel,
//                         color: ColorConstants.whiteColor,
//                         size: 35,
//                       ))),
//             ),
//           )
//         ],
//       );
//     } else if (mediaPreviewWrapper.assetType == "video") {
//       return Center(
//         child: FullScreenVideoPlayer(url: mediaPreviewWrapper.asset ?? ''),
//       );
//     } else {
//       return const Text("Not Supported");
//     }
//   }
// }
