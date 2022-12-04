import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/typography.dart';

class GlobalFunctions {
  static void botomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(children: [
              Container(
                height: 60,
                child: Stack(
                  children: [
                    Align(
                      alignment: FractionalOffset.center,
                      child: LargeText(
                        text: 'Filters',
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [],
              )
            ]),
          );
        });
  }
}

ImageProvider useAssetIfImageNull({String assetUri = "", String? imgPath}) {
  if (imgPath == "" || imgPath == null) {
    return AssetImage(assetUri);
  } else {
    return NetworkImage(imgPath);
  }
}

ImageProvider setProduceImage(String? uri) {
  return useAssetIfImageNull(assetUri: "assets/images/logo.png", imgPath: uri);
}

ImageProvider setProfileImage(String? uri) {
  return useAssetIfImageNull(
      assetUri: "assets/images/defaultProfile.png", imgPath: uri);
}

void launchApplication(String data) async {
  if (!data.contains("@")) {
    await launchUrl(Uri(scheme: "tel", path: data));
  } else {
    await launchUrl(Uri(scheme: "mailto", path: data));
  }
}
