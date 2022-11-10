import 'dart:ffi';

import 'category.model.dart';

class Product{
  final String prod_name;
  final String prod_img;
  final String category;
  final String id;
  final bool inSeason;

  Product({this.prod_name = "", this.id="", this.prod_img="", this.category = "", this.inSeason = false});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      prod_img: json["prod_img"],
      prod_name: json["prod_name"],
      category: json["category"],
      id: json["_id"],
      inSeason: (json["inSeason"] == null )? false : (json["inSeason"] == true ) ? true : false
    );
  }



  Map<String, dynamic> toJson(){
    return {
      "prod_img": this.prod_img,
      "prod_name": this.prod_name,
      "category": this.category,
    };
  }
}