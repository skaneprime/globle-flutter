import 'package:flutter/material.dart';

Dialog leadDialog = Dialog(
  child: Container(
    height: 300.0,
    width: 360.0,
    color: Color.fromARGB(255, 194, 251, 253),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Statistics',
            style: TextStyle(color: Colors.black, fontSize: 35.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: <Widget>[
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
                    'Today\'s guesses',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Games won',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Current streak',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Max streak',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Average guesses',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '--',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 255, 255, 255),
                ),
                foregroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 209, 6, 6),
                ),
                overlayColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 209, 6, 6),
                ),
                surfaceTintColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              child: const Text(
                "Reset",
                style: TextStyle(
                  decorationColor: Color.fromARGB(1, 255, 255, 255),
                ),
              ),
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
