
class User {
  final String id;
  final String first_name;
  final String last_name;
  final String image;
  final String email;
  final Map<String, dynamic> address;
  final String phone;
  final bool isSuperAdmin;
  // final String password;
  final bool isFarmer;

  User({
    this.id = "",
    this.first_name ="",
    this.last_name="",
    this.email = "",
    required this.address,
    this.image = "",
    this.isSuperAdmin = false,
    this.phone="",
    this.isFarmer = false });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
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
      isFarmer: json["isFarmer"],
    );
  }
}





