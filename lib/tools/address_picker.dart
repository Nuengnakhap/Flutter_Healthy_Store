import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

CameraPosition defaultLocation =
    CameraPosition(target: LatLng(13.730801, 100.781775), zoom: 15);

class AddressPicker extends StatefulWidget {
  String userId;
  DocumentSnapshot location;
  AddressPicker({this.userId});
  AddressPicker.update(this.location);
  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition mapPosition = defaultLocation;
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

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      addressName.text = widget.location.data["addressname"];
      fullName.text = widget.location.data["fullname"];
      phone.text = widget.location.data["phone"];
      address.text = widget.location.data["address"];
      province.text = widget.location.data["province"];
      district.text = widget.location.data["district"];
      zipCode.text = widget.location.data["zipcode"];
      mapPosition = CameraPosition(
          target: LatLng(widget.location.data["location"].latitude,
              widget.location.data["location"].longitude),
          zoom: 16);
      addMarker();
    }
  }

  void addMarker() {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(mapPosition.toString()),
        position: mapPosition.target,
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
                        if (widget.location == null) {
                          await appMethods.setAddress(
                            userId: widget.userId,
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
                        } else {
                          appMethods.updateAddress(
                            ref: widget.location.reference,
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
                        }
                        // Navigator.pushReplacementNamed(context, "/");
                        Navigator.pop(context);
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
        // myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: mapPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: (CameraPosition newMapPosition) {
          mapPosition = newMapPosition;
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
