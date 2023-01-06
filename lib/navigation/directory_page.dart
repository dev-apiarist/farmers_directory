import 'dart:convert';
import 'package:farmers_directory/models/farmer.model.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:flutter/material.dart';
import '../models/product.model.dart';
import '../pages/users/lists/farmers_list.dart';
import '../utils/dimensions.dart';
import '../widgets/typography.dart';

class Directory extends StatefulWidget {
  const Directory({super.key});

  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  late Future<List<Farmer>> farmerList;
  List<Product> products = [];

  Future<List<Farmer>> getFarmers() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/farmers"));
    List farmers = response["data"];
    List<Farmer> farmerList = farmers.map((farmer) {
      return Farmer.fromJson(farmer);
    }).toList();
    return farmerList;
  }

  getProducts() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/products"));
    List productsList = response["data"];
    setState(() {
      products = productsList.map((product) {
        return Product.fromJson(product);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    farmerList = getFarmers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: Dimensions.width70,
          child: Image.asset(
            'assets/icons/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Farmer>>(
        future: farmerList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const LargeText(text: 'Farmers'),
                    ),
                    TextButton(
                      onPressed: () {
                        GlobalFunctions.botomSheet(context);
                      },
                      child: IconButton(
                        icon: Icon(Icons.sort),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: ((context, index) => const Divider()),
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FarmersList(farmer: snapshot.data![index]);
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return showError(
                snapshot.error, farmerList, setState, getFarmers, context);
          }
        },
      ),
    );
  }
}
