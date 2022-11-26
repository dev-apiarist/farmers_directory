
class Consumer {
  String? id = "";
  String? first_name = "";
  String? last_name = "";
  String? image = "";
  String? email = "";
  Map<String, dynamic> address = {
    "city": "",
    "street": "",
    "parish": ""
  };
  String? phone = "";
  bool? isSuperAdmin = false;
  String? password = "";

  Consumer({this.id,this.first_name, this.last_name, this.email, required this.address,this.image, this.isSuperAdmin, this.phone });

  factory Consumer.fromJson(Map<String, dynamic> json){
    return Consumer(
      id: json["_id"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      email:json["email"],
      address: json["address"] ?? {
        "city": "",
        "street": "",
        "parish": ""
      },
      image: json["image"] ?? "",
      isSuperAdmin: json["isSuperAdmin"] ?? false,
      phone: json["phone"] ?? "",
    );
  }
}





