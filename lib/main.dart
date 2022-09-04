import 'package:flutter/material.dart';
import 'package:globe_flutter_android/title.dart';

void main() {
  runApp(MaterialApp(
    title: 'GLOBLE',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const Scaffold(
      body: TitleWidget(),
    ),
  ));
}
