import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.message}) : super(key: key);
  final String? message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key:key,
     content: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         circularProgress(),
         SizedBox(height:10),
         Text(message! + "Please wait..."),
       ],
     ),
    );
  }
}
