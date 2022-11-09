class Category{
  final String id;
  final String category_name;
  final String category_img;


  Category({this.id = "",this.category_name = "", this.category_img=""});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["_id"],
      category_img: json["category_img"],
      category_name: json["category_name"]
    );
  }

  Map<String, String>toJson(){
    return {
      "_id": this.id,
      "category_img": this.category_img,
      "category_name": this.category_name
    };
  }

}