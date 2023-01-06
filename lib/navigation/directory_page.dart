import 'dart:convert';
import 'package:farmers_directory/models/farmer.model.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:flutter/material.dart';
import '../models/product.model.dart';
import '../pages/users/lists/farmers_list.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/leading_icon.dart';
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
        foregroundColor: Colors.black,
        title: SizedBox(
          width: Dimensions.width70,
          child: Image.asset(
            'assets/icons/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.65,
        elevation: 0,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.mainGreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: SizedBox(
                      width: Dimensions.width70,
                      child: Image.asset(
                        'assets/icons/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: LeadingIconText(
                iconSize: Dimensions.iconSize16,
                icon: Icons.person,
                text: 'Account',
              ),
            ),
            const Divider(),
            ListTile(
              title: LeadingIconText(
                iconSize: Dimensions.iconSize16,
                icon: Icons.settings,
                text: 'Settings',
              ),
            ),
            const Divider(),
            ListTile(
              title: LeadingIconText(
                iconSize: Dimensions.iconSize16,
                icon: Icons.feedback,
                text: 'Send Feedback',
              ),
            ),
            const Divider(),
            ListTile(
              title: LeadingIconText(
                iconSize: Dimensions.iconSize16,
                icon: Icons.logout,
                text: 'Logout',
              ),
            ),
            const Divider(),
          ],
        ),
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
