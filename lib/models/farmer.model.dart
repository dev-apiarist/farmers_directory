import 'package:farmers_directory/models/product.model.dart';
import 'package:farmers_directory/models/user.model.dart';

class Farmer extends User {
  final String description;
  final Map<String, dynamic> socials;
  // final String id_number;
  final String farmer_type;
  List<Product> products = [];

  Farmer(
      {super.id = "",
      super.first_name = "",
      super.last_name = "",
      this.farmer_type = "",
      super.image = "",
      super.email = "",
      this.description = "",
      super.address = const {},
      // this.id_number = "",
      super.phone = "",
      this.socials = const {},
      required this.products});

  factory Farmer.fromJson(Map<String, dynamic> json) {
    List productList = json["products"];
    List<Product> products =
        productList.map((product) => Product.fromJson(product)).toList();
    return Farmer(
        id: json["_id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        farmer_type: json["farmer_type"] ?? "",
        image: json["image"] ?? "",
        email: json["email"],
        description: json["description"],
        // id_number: json["id_number"],
        phone: json["phone"],
        socials:
            json["socials"] ?? {"instagram": "", "website": "", "facebook": ""},
        address: json["address"] ?? {"street": "", "city": "", "parish": ""},
        products: products);
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": this.first_name,
      "last_name": this.last_name,
      "farmer_type": this.farmer_type,
      "image": this.image,
      "email": this.email,
      "description": this.description,
      // "id_number": this.id_number,
      "phone": this.phone,
      "socials": this.socials,
      "address": this.address,
      "products": this.products,
    };
  }
}
