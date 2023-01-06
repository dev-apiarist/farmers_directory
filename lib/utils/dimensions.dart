import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; //868
  static double screenWidth = Get.context!.width; //411

// dynamic height cards container
  static double pageView = screenHeight / 3.94;
  static double pageViewContainer = screenHeight / 4.44;
  static double pageViewTextContainer = screenHeight / 7.03;

// dynamic height padding and margin
  static double height5 = screenHeight / 173.6;
  static double height8 = screenHeight / 108.5;
  static double height10 = screenHeight / 86.8;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 43.4;
  static double height40 = screenHeight / 20.27;
  static double height50 = screenHeight / 17.36;
  static double height70 = screenHeight / 12.4;

// dynamic width padding and margin
  static double width2 = screenWidth / 205.5;
  static double width5 = screenWidth / 82.2;
  static double width10 = screenWidth / 41.1;
  static double width15 = screenWidth / 27.4;
  static double width20 = screenWidth / 20.55;
  static double width30 = screenWidth / 13.7;
  static double width40 = screenWidth / 10.28;
  static double width70 = screenWidth / 5.87;

//fonts
  static double sm = screenHeight / 62.04; //14
  static double lg = screenHeight / 48.25; //18
  static double xl = screenHeight / 39.48; //22
  static double xxl = screenHeight / 33.41; //28

//  radius
  static double radius5 = screenHeight / 162.2;
  static double radius10 = screenHeight / 84.4;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 27.03;

  // icon size = 24
  static double iconSize20 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 54.25;

//
  static double inSeasonContPri = screenHeight / 2.79;
  static double inSeasonContSec = screenHeight / 3;

  //featured produce
  static double featuredProduceImgContSize = screenHeight / 2.28;
  static double featuredProduceImgSize = screenHeight / 2.89;

  // expandedHeight of sliver
  static double expandedHeight = screenHeight / 2.89;
  static double welcomePageImg = screenHeight / 1.55;

  // logo

  static double logoSize = screenHeight / 8.68;
  static double logoPos = screenHeight / 1.88;
}
