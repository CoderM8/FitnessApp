import 'dart:io';

import 'package:fitness_ui/services/service.dart';
import 'package:package_info_plus/package_info_plus.dart';

String? version;
String? appPrivacy;
String? appTerms;
String get shareApp {
  if (Platform.isAndroid) {
    return "https://play.google.com/store/apps/details?id=com.vocsy.cc.fitness";
  } else if (Platform.isIOS) {
    return "https://apps.apple.com/in/app/pro-fitness/id6504170758";
  } else {
    return "PlatformException ${Platform.operatingSystem}";
  }
}

String get rateApp {
  if (Platform.isAndroid) {
    return "https://play.google.com/store/apps/details?id=com.vocsy.cc.fitness";
  } else if (Platform.isIOS) {
    return "https://itunes.apple.com/app/id6504170758?action=write-review";
  } else {
    return "PlatformException ${Platform.operatingSystem}";
  }
}

Future<void> initAppDetails() async {
  await HttpService.appDetails().then((value) {
    if (value != null) {
      final data = value.fitnessApp[0];
      appPrivacy = data.appPrivacyPolicy;
      appTerms = data.terms;
    }
  });
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = "${packageInfo.version}(${packageInfo.buildNumber})";
}
// String? googleAppId = 'ca-app-pub-1031554205279977~4849970914';
// String? facebookAppId = '837404648236305';
//
// String? googleBannerAndroid;
// String? googleBannerIOS = 'ca-app-pub-1031554205279977/5420369448';
// String? facebookBannerAndroid;
// String? facebookBannerIOS = '1138984414003847_1139064633995825';
//
// String? googleInterstitialAndroid;
// String? googleInterstitialIOS = 'ca-app-pub-1031554205279977/4031713261';
// String? facebookInterstitialAndroid;
// String? facebookInterstitialIOS = '1138984414003847_1139064757329146';
//
// String? googleRewardedAndroid;
// String? googleRewardedIOS = 'ca-app-pub-1031554205279977/4107287770';
// String? facebookRewardedAndroid;
// String? facebookRewardedIOS = '1138984414003847_1139064993995789';
//
// class AdsTestAdIdManager extends IAdIdManager {
//   AdsTestAdIdManager();
//
//   @override
//   AppAdIds? get fbAdIds => AppAdIds(
//         appId: facebookAppId!,
//         bannerId: Platform.isIOS ? facebookBannerIOS : facebookBannerAndroid,
//         interstitialId: Platform.isIOS ? facebookInterstitialIOS : facebookInterstitialAndroid,
//         rewardedId: Platform.isIOS ? facebookRewardedIOS : facebookRewardedAndroid,
//       );
//
//   @override
//   AppAdIds? get admobAdIds => AppAdIds(
//         appId: googleAppId!,
//         bannerId: Platform.isIOS ? googleBannerIOS : googleBannerAndroid,
//         interstitialId: Platform.isIOS ? googleInterstitialIOS : googleInterstitialAndroid,
//         rewardedId: Platform.isIOS ? googleRewardedIOS : googleRewardedAndroid,
//       );
//
//   @override
//   AppAdIds? get unityAdIds => null;
//
//   @override
//   AppAdIds? get appLovinAdIds => null;
// }
//
// /// Banner Ads
// Widget bannerAds() {
//   return const EasySmartBannerAd(priorityAdNetworks: [AdNetwork.facebook, AdNetwork.admob], adSize: AdSize.banner);
// }
//
// /// Interstitial & Rewarded Ads
// void showAd(AdUnitType adUnitType) {
//   if (adUnitType == AdUnitType.interstitial) {
//     if (EasyAds.instance.showAd(adUnitType, adNetwork: AdNetwork.facebook))
//       ;
//     else
//       EasyAds.instance.showAd(adUnitType, adNetwork: AdNetwork.admob);
//   } else if (adUnitType == AdUnitType.rewarded) {
//     if (EasyAds.instance.showAd(adUnitType, adNetwork: AdNetwork.facebook))
//       ;
//     else
//       EasyAds.instance.showAd(adUnitType, adNetwork: AdNetwork.admob);
//   }
// }
