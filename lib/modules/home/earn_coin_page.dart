import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import '../../constants/custom_colors.dart';
import '../../global/global_view/custom_button.dart';

class EarnCoinPage extends StatefulWidget {
  const EarnCoinPage({Key? key, required this.userRepository})
      : super(key: key);
  final UserRepository userRepository;
  @override
  State<EarnCoinPage> createState() => _EarnCoinPageState();
}

class _EarnCoinPageState extends State<EarnCoinPage> {
  final AdMobHelper _adMobHelper = AdMobHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adMobHelper.initilization();
    _adMobHelper.loadRewardAd();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: CustomColors.foreGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomText(
              text: 'Your total points are',
              color: CustomColors.textWhiteColor,
            ),
            CustomText(
              // text: widget.userRepository.currentUser().points.toString(),
              text: '10',
              fontWeight: FontWeight.w600,
              fontSize: 44.sp,
              color: CustomColors.textYellowColor,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
              child: CustomButton(
                  text: 'Watch another',
                  onTap: () {
                    _adMobHelper.loadRewardAd();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class AdMobHelper {
  static String get bannerAdUnit => "ca-app-pub-3940256099942544~3347511713";

  late InterstitialAd _interstitialAd;

  late RewardedAd _rewardedAd;

  int number_of_attempt_load = 0;

  void initilization() {
    MobileAds.instance.initialize();
  }

  void loadRewardAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          showRewardAd();
        },
        onAdFailedToLoad: (LoadAdError err) {
          loadRewardAd();
        },
      ),
    );
  }

  void showRewardAd() {
    _rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem item) {
        log('Reward EARNED ${item.amount}');
      },
    );

    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {},
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError err) {
        ad.dispose();
        _rewardedAd.dispose();
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _rewardedAd.dispose();
      },
      onAdImpression: (RewardedAd ad) => log('$ad impression occurred'),
    );
  }
}
