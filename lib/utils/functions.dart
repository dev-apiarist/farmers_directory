import 'package:flutter/material.dart';

import '../widgets/text.dart';

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


ImageProvider useAssetIfImageNull({String assetUri= "" , String? imgPath}){
  print(imgPath);
  if(imgPath == "" || imgPath == null){
    return AssetImage(assetUri);
  }else{
    return NetworkImage(imgPath);
  }
}

ImageProvider setProfileImage(String? uri){
  return useAssetIfImageNull(assetUri:"assets/images/defaultProfile.png", imgPath: uri);
}