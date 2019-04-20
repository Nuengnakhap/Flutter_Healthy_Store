import 'dart:io';

import 'package:flutter/material.dart';

import 'package:store_app_proj/tools/image_picker_handler.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'CART',
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: new GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: new Center(
          child: _image == null
              ? new Stack(
                  children: <Widget>[
                    new Center(
                      child: new CircleAvatar(
                        radius: 80.0,
                        backgroundColor: const Color(0xFF778899),
                      ),
                    ),
                    new Center(
                      child: new Image.asset("assets/images/photo_camera.png"),
                    ),
                  ],
                )
              : new Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      image: new ExactAssetImage(_image.path),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.red, width: 5.0),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(80.0)),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}

// https://www.developerlibs.com/2018/08/flutter-capture-image-from-camera-or.html