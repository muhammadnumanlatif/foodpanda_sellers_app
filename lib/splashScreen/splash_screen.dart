import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/authentication/auth_screen.dart';
import 'package:foodpanda_sellers_app/global/global.dart';

import '../mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  
  
  startTimer(){
    Timer(const Duration(seconds: 8), ()async{
     if(firebaseAuth.currentUser!=null){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
     }else{
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen()));
     }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset("images/splash.jpg"),
            const SizedBox(height: 10,),
            const Padding(
               padding: EdgeInsets.all(18.0),
               child: Text("Sell Food Online",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black54,
                   fontSize: 40,
                   letterSpacing: 3,
                 ),
               ),
             )
           ],
         ),
       ),
    );
  }
}
