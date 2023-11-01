// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;
  AdRequest get request => AdRequest();
  VoidCallback? onAdLoadedCallback;

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
          onAdLoadedCallback?.call();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  // RewardedAd? _rewardedAd;
  // void showRewardedAd(BuildContext context) async {
  //   await RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: request,
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (RewardedAd ad) {
  //         print('$ad loaded');
  //         _rewardedAd = ad;
  //         _rewardedAd?.show(onUserEarnedReward: (Ad ad, RewardItem reward) {
  //           print('User earned ${reward.amount} ${reward.type}');

  //           final scanCounterProvider =
  //               Provider.of<ScanCounterProvider>(context, listen: false);
  //           scanCounterProvider.reset();
  //           showDialog(
  //             context: context,
  //             builder: (context) {
  //               return ShowDialogCongratulation();
  //             },
  //           );
  //           _rewardedAd = null;
  //         });
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('RewardedAd failed to load: $error.');
  //         _rewardedAd = null;
  //       },
  //     ),
  //   );
  // }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      onAdLoadedCallback = () {
        onAdLoadedCallback = null;
        showInterstitialAd();
      };
      createInterstitialAd();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
