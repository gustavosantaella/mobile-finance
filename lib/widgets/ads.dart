import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
BannerAd simpleAd(String adUnitId) {
  return BannerAd(
    adUnitId: adUnitId,
    request: const AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        logger.w("Banner is loaded");
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (ad, err) {
        logger.w("Error to load simpleBanner");

        // Dispose the ad here to free resources.
        ad.dispose();
      },
    ),
  )..load();


}
