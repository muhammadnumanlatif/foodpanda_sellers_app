import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/mainScreens/home_screen.dart';


import '../authentication/auth_screen.dart';
import '../global/global.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("photoUrl")!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),

          //drawer body
          Container(
            padding: EdgeInsets.only(top: 1),
            child: Column(
              children: [
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),

                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const HomeScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: Text(
                    "New Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_shipping,
                    color: Colors.black,
                  ),
                  title: Text(
                    "History - Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthScreen()));
                    });
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
