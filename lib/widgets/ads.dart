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
        logger.w({
          "message": "Banner is loaded",
          "ad": ad
        });
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (ad, err) {
        logger.w({
          "message": "Error to load simpleBanner",
          "add": ad,
          "error": err
        });

        // Dispose the ad here to free resources.
        ad.dispose();
      },
    ),
  )..load();


}
