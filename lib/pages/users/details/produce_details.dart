import 'dart:convert';

import 'package:farmers_directory/pages/users/lists/farmers_list.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/app_icon.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

import '../../../models/farmer.model.dart';
import '../../../models/product.model.dart';
import '../../../services/network_handler_service.dart';
import 'farmer_details.dart';

class ProduceDetails extends StatefulWidget {
  const ProduceDetails({super.key, required this.product});
  final Product product;

  @override
  State<ProduceDetails> createState() => _ProduceDetailsState();
}

class _ProduceDetailsState extends State<ProduceDetails> {

  late Future<List<Farmer>> farmers;
  Future<List<Farmer>> getFarmers() async{
    Map<String, dynamic> response = jsonDecode(await NetworkHandler.get(endpoint: "/farmers", queryParams:"product=${widget.product.id}" ));
    List farmers = response["data"];
    return farmers.map((farmer){
      return Farmer.fromJson(farmer);
    }).toList();

  }

  @override
  void initState() {
    farmers = getFarmers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Farmer>>(
        future: farmers,
        builder:(context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData){
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: Dimensions.expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image(image: setProfileImage(widget.product.prod_img))
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Container(
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: SmallText(
                          text: '${snapshot.data!.length} Farmers are selling ${widget.product.prod_name}',
                          size: Dimensions.height20,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ListView.separated(
                        separatorBuilder: ((context, index) => Divider()),
                        padding: EdgeInsets.only(top: Dimensions.height10),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FarmersList(farmer: snapshot.data![index]);
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }else{
            print(snapshot.error);
            return Center(child: Text('${snapshot.error}'));
          }
        },
      ),
    );
  }
}
