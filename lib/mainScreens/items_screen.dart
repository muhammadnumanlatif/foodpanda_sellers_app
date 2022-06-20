import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_sellers_app/widgets/item_design.dart';
import 'package:foodpanda_sellers_app/widgets/my_drawer.dart';
import 'package:foodpanda_sellers_app/widgets/text_widget_header.dart';

import '../global/global.dart';
import '../models/items.dart';
import '../models/menus.dart';
import '../uploadScreen/items_upload_screen.dart';
import '../widgets/info_design.dart';
import '../widgets/progress_bar.dart';

class ItemsScreen extends StatefulWidget {
  ItemsScreen({Key? key, this.model}) : super(key: key);
final Menus? model;
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin:FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops:[0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(sharedPreferences!.getString("name")!),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (c)=> ItemsUploadScreen(model: widget.model)));
          }, icon: Icon(Icons.library_add, color: Colors.cyan,))
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString() + "'s Items")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(sharedPreferences!.getString("uid")).collection("menus").doc(widget.model!.menuID).collection("items").orderBy("publishedDate",descending: true).snapshots(),
            builder: (context, snapshot){
              return !snapshot.hasData
                  ?SliverToBoxAdapter(
                child: Center(child: circularProgress()),
              )
                  : SliverToBoxAdapter(
                child: GridView.custom(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount:2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [

                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 2),
                    ],
                  ),

                  childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                      Items model = Items.fromJson(snapshot.data!.docs[index].data()! as Map<String,dynamic>);
                      return ItemsDesignWidget(
                        model: model,
                        context: context,
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
