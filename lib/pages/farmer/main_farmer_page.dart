import 'dart:convert';

import 'package:farmers_directory/pages/farmer/lists/farmer_produce_list.dart';
import 'package:farmers_directory/pages/users/lists/produce_list.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

import '../../models/category.model.dart';
import '../../models/farmer.model.dart';
import '../../models/product.model.dart';
import '../../models/user.model.dart';
import '../../services/network_handler_service.dart';
import '../../services/secure_store_service.dart';
import '../../utils/dimensions.dart';
import '../auth/farmer_sign_up.dart';

class MainFarmerPage extends StatefulWidget {
  MainFarmerPage({super.key ,required Farmer this.farmer});
  final Farmer farmer;
  @override
  State<MainFarmerPage> createState() => _MainFarmerPageState();
}

class _MainFarmerPageState extends State<MainFarmerPage> {
  TextEditingController searchCtrl = TextEditingController();
  List<Category> allCategories = [];
  String query = "";
  List<String> selectedProducts = [];
  Color selectedColor = AppColors.mainGold.withOpacity(0.4);
  String id = "";

  List<String> getFarmerProducts(){
    return widget.farmer.products.map((product)=> product.id).toList();
  }
  late Future<List<Product>> productList;
  Future<List<Product>> getAllProducts() async{
    try{
      allCategories = await getAllCategories();

      List productList = jsonDecode(await NetworkHandler.get(endpoint: "/products"))["data"];
      setState((){});

      return productList.map((product){
        return Product.fromJson(product);
      }).toList();
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      return [];

    }
  }
  Future<List<Category>> getAllCategories() async{
    try{
      List categoryList = jsonDecode(await NetworkHandler.get(endpoint: "/categories"))["data"];
      return categoryList.map((category){
        return Category.fromJson(category);
      }).toList();
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      return [];

    }
  }
  // Future<User> getUser() async {
  //   User currentUser = await SecureStore.getUser();
  //   if(currentUser.isFarmer){
  //     Map<String, dynamic>farmerData = jsonDecode(await NetworkHandler.get(endpoint: "/farmers/${currentUser.id}"))["data"];
  //     print(farmerData);
  //     farmer = Farmer.fromJson(farmerData);
  //   }
  //   setState(() {
  //     id = currentUser.id!;
  //     selectedProducts = farmer.products.map((p)=>p.id).toList();
  //   });
  //   return currentUser;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.selectedProducts = getFarmerProducts();
    productList = getAllProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: FutureBuilder(
        future: productList,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(text: "Search Products"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: searchCtrl,

                            scrollPhysics: BouncingScrollPhysics(),
                            keyboardType:TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    BorderSide(color: Colors.grey.withOpacity(0.4))),
                                contentPadding: EdgeInsets.all(15),
                                hintText: "Search",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                    filled: true,
                                    fillColor: Colors.white70
                                ),
                            onChanged: (value){
                              query = searchCtrl.text;
                              setState(() {});
                            }

                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: allCategories.map((category){
                      List<Product> filteredList = snapshot.data!.where((product) => product.category == category.id ).toList();
                      filteredList = filteredList.where((element)=> element.prod_name.toLowerCase().contains(query.toLowerCase())).toList();
                      filteredList.sort((prod1, prod2)=>prod1.prod_name.compareTo(prod2.prod_name));
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(category.category_name, style:TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            Wrap(
                              spacing: Dimensions.width5,
                              children:
                              List.generate(filteredList.length, (index) {
                                return GestureDetector(
                                  onTap: (() {
                                    toggleSelectedToList(productList: selectedProducts, productId: filteredList[index].id);
                                    setState(() {});
                                  }),
                                  child: Chip(
                                    backgroundColor: isSelected(productList:selectedProducts, productId: filteredList[index].id) ? selectedColor: Colors.white,
                                    side: BorderSide(color: Colors.black54),
                                    label: SmallText(
                                      size: 13,
                                      text: '${filteredList[index].prod_name}',
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ]
                      );


                    }).toList(),
                  ),
                ],
              ),
            );
          }else{
            return Center(child:CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
