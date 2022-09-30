import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(
    home: AdDemo(),
  ));
}

class AdDemo extends StatefulWidget {
  const AdDemo({Key? key}) : super(key: key);

  @override
  State<AdDemo> createState() => _AdDemoState();
}

class _AdDemoState extends State<AdDemo> {
  BannerAd? bannerAd;
  bool isloaded=false;
  @override
  void initState() {
    super.initState();
    createad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: 200,
          width: 200,
          color: Colors.green,
        ),
        bottomNavigationBar: bannerAd == null
            ? Container(height: 200, width: 200, color: Colors.green)
            : Container(
                height: 70,
                margin: EdgeInsets.only(bottom: 20),
                child: AdWidget(ad: bannerAd!),
              ));
  }

  createad() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544~3347511713',
        listener: BannerAdListener(onAdLoaded:(ad){
          setState(() {
            isloaded=true;
          });
          print('ad success');
        },
          onAdFailedToLoad: (ad, error) {
            bannerAd!.dispose();
          },
        ),
        request: AdRequest());
    bannerAd!.load();
  }
}
