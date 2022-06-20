import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/mainScreens/items_screen.dart';
import 'package:foodpanda_sellers_app/models/menus.dart';


class InfoDesignWidget extends StatefulWidget {
Menus? model;

BuildContext? context;

InfoDesignWidget({
  this.model,
  this.context,
});
  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model: widget.model)));
      },
       splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          height: 485,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
height: MediaQuery.of(context).size.height*0.15,
                      width: MediaQuery.of(context).size.height,

                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1,),
              Text(widget.model!.menuTitle!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              ),
              Text(widget.model!.menuInfo!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12 ,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

