// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
// class ShareCardService {
//   Future<String> createDynamicLink() async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://gitME.page.link',
//       link: Uri.parse('https://gitME.page.link/card?id=1'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.your.package.name',
//       ),
//       iosParameters: IosParameters(
//         bundleId: 'your.bundle.identifier',
//         minimumVersion: 'your-minimum-ios-version',
//       ),
//     );
//
//     final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
//     return dynamicUrl.shortUrl.toString();
//   }
// }
