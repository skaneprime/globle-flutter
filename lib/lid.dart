import 'package:flutter/material.dart';

Dialog leadDialog = Dialog(
  child: Container(
    height: 300.0,
    width: 360.0,
    color: const Color.fromARGB(255, 172, 44, 44),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            'Choose from Library',
            style: TextStyle(color: Colors.black, fontSize: 22.0),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Last win',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Reset"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Shure"),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            'New game from the creator of Globle!',
            style: TextStyle(fontFamily: "Nunito"),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Plurality"),
          ),
        ),
      ],
    ),
  ),
);
