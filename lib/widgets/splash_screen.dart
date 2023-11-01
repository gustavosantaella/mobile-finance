import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:flutter/material.dart';
import 'package:wafi/widgets/ads.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  BannerAd? _bannerAd;
  BannerAd? _bannerAd2;

  @override
  void initState() {
    _bannerAd = simpleAd(ads['banner1'] as String);
    _bannerAd2 = simpleAd(ads['banner1'] as String);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          color: definitions['colors']['splash']['main'],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_bannerAd != null)
                SizedBox(
                  width: _bannerAd?.size.width.toDouble(),
                  height: 100,
                  child: AdWidget(ad: _bannerAd!),
                ),
              const Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  'WAFI',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      letterSpacing: 10,
                      shadows: normalShadow),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  lang("You can manage your finances with me"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      letterSpacing: 10,
                      shadows: normalShadow),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/app_icon.png',
                width: 150,
                height: 150,
              ),
              if (_bannerAd2 != null)
                SizedBox(
                  width: _bannerAd?.size.width.toDouble(),
                  height: 100,
                  child: AdWidget(ad: _bannerAd2!),
                ),
            ],
          ),
        ));
  }
}
