import 'package:flutter/material.dart';

class MenuModel {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const MenuModel({this.onTap, required this.icon, required this.title});
}
