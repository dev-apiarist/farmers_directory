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
  static double height10 = screenHeight / 86.8;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 43.4;

// dynamic width padding and margin

  static double width5 = screenWidth / 82.2;
  static double width10 = screenWidth / 41.1;
  static double width15 = screenHeight / 27.4;
  static double width20 = screenHeight / 20.55;
  static double width30 = screenHeight / 13.7;

//fonts
  static double font17 = screenHeight / 51.05;
  static double font14 = screenHeight / 62;
  static double font30 = screenHeight / 28.93;
//  radius

  static double radius10 = screenHeight / 84.4;
  static double radius20 = screenHeight / 42.2;

  // icon size = 24
  static double iconSize20 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 54.25;

  //List view Size
  static double ListViewImageSize = screenWidth / 3.4;
  static double ListViewTextContainer = screenWidth / 3.4;

  //featured produce
  static double featuredProduceImgContSize = screenHeight / 2.28;
  static double featuredProduceImgSize = screenHeight / 2.89;

  // expandedHeight of sliver
  static double expandedHeight = screenHeight / 2.89;

  //
  static double welcomePageImg = screenHeight / 1.55;
}
