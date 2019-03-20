import 'package:flutter/material.dart';

double baseHeight = 720.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height/baseHeight;
}