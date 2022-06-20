import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_sellers_app/authentication/auth_screen.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/uploadScreen/menus_upload_screen.dart';
import 'package:foodpanda_sellers_app/widgets/my_drawer.dart';
import 'package:foodpanda_sellers_app/widgets/progress_bar.dart';
import 'package:foodpanda_sellers_app/widgets/text_widget_header.dart';

import '../models/menus.dart';
import '../widgets/info_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
            Navigator.push(context,MaterialPageRoute(builder: (c)=>MenusUploadScreen()));
          }, icon: Icon(Icons.post_add, color: Colors.cyan,))
        ],
      ),
      body: CustomScrollView(
        slivers: [
         SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("sellers").doc(sharedPreferences!.getString("uid")).collection("menus").orderBy("publishedDate",descending: true).snapshots(),
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
                    Menus sModel = Menus.fromJson(snapshot.data!.docs[index].data()! as Map<String,dynamic>);
                    return InfoDesignWidget(
                      model: sModel,
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
