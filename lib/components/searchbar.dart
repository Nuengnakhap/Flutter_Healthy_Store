import 'package:flutter/material.dart';
import 'package:store_app_proj/components/CustomShapeClipper.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: CustomShapeClipper(),
        child: Container(
          height: 300.0, color: Colors.teal,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       colors: [firstColor, secondColor],
          //       begin: const FractionalOffset(0.5, 0.0),
          //       end: const FractionalOffset(0.0, 0.5),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                'What would\nyou want to buy ?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: TextField(
                    controller: search,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 14.0),
                        border: InputBorder.none,
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
