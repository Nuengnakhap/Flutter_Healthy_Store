import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class AddressPicker extends StatefulWidget {
  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _lastMapPosition = start;
  Set<Marker> _markers = {};
  FirebaseMethods appMethods = FirebaseMethods();
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  

  void addMarker() {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition.target,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void confirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(12),
            title: Text("Fill this information"),
            titlePadding: EdgeInsets.all(12),
            content: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: addressName,
                    decoration: InputDecoration(
                        labelText: "Address Name",
                        helperText: "Ex: Home or Work place"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                    },
                  ),
                  TextFormField(
                    controller: fullName,
                    decoration: InputDecoration(labelText: "Reciever Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                    },
                  ),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(labelText: "Phone number"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      } else if (value.length > 10) {
                        return "This in not a phone number";
                      }
                    },
                  ),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(labelText: "Address"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                    },
                  ),
                  TextFormField(
                    controller: district,
                    decoration: InputDecoration(labelText: "Distict"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                    },
                  ),
                  TextFormField(
                    controller: province,
                    decoration: InputDecoration(labelText: "Province"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill out this form";
                      }
                    },
                  ),
                  TextFormField(
                    controller: zipCode,
                    decoration: InputDecoration(labelText: "Zip Code"),
                    validator: (value) {
                      if (value.length != 5) {
                        return "This is not a zip code";
                      }
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await appMethods.setAddress(
                          addressName: addressName.text,
                          fullname: fullName.text,
                          phone: phone.text,
                          address: address.text,
                          province: province.text,
                          district: district.text,
                          zipcode: zipCode.text,
                          latitude: _markers.elementAt(0).position.latitude,
                          longitude: _markers.elementAt(0).position.longitude,
                        );
                        Navigator.pushReplacementNamed(context, "/");
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
        centerTitle: false,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: start,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: (CameraPosition newMapPosition) {
          _lastMapPosition = newMapPosition;
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    _markers.length == 0 ? "Pin Location" : "Replace Location",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  onPressed: addMarker,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 2,
                child: _markers.length == 0
                    ? RaisedButton(
                        color: Colors.red,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : RaisedButton(
                        color: Colors.green,
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: confirm,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

CameraPosition start =
    CameraPosition(target: LatLng(13.730801, 100.781775), zoom: 16);
