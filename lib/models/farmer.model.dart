import 'package:farmers_directory/models/product.model.dart';

class Farmer {
  final String id;
  final String fname;
  final String lname;
  final String farmer_type;
  final String image;
  final String email;
  final String description;
  final Map<String, dynamic> address;
  final Map<String, dynamic> socials;
  final String phone;
  final String id_number;
  final String password;
  List<Product> products = [];

  Farmer({
    this.id = "",
    this.fname="",
    this.lname="",
    this.farmer_type="",
    this.image="",
    this.email="",
    this.description="",
    this.address= const{},
    this.id_number="",
    this.phone="",
    this.socials=const{},
    this.password = "", required this.products
  });

  factory Farmer.fromJson(Map<String, dynamic> json){
    List productList = json["products"];
    List<Product> products = productList.map((product) => Product.fromJson(product)).toList();
    return Farmer(
      id: json["_id"],
      fname: json["fname"],
      lname: json["lname"],
      farmer_type: json["farmer_type"] ?? "",
      image: json["image"] ?? "",
      email: json["email"],
      description: json["description"],
      id_number: json["id_number"],
      phone: json["phone"],
      socials: json["socials"] ?? {"instagram": "", "website":"", "facebook": ""},
      address: json["address"] ?? {"street": "", "city":"", "parish": ""},
      products: products
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "fname": this.fname,
      "lname": this.lname,
      "farmer_type": this.farmer_type,
      "image": this.image,
      "email": this.email,
      "description": this.description,
      "id_number": this.id_number,
      "phone": this.phone,
      "socials": this.socials,
      "address": this.address,
      "password": this.password,
      "products": this.products,
    };
  }
}