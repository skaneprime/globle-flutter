import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

Dialog leadDialog = Dialog(
  child: Consumer<ThemeModel>(
    builder: (context, theme, child) => Container(
      height: 300.0,
      width: 360.0,
      color: theme.mode == ThemeMode.light
          ? const Color.fromARGB(255, 194, 251, 253)
          : const Color.fromARGB(255, 24, 33, 63),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Statistics',
              style: TextStyle(
                  color: theme.mode == ThemeMode.light
                      ? const Color.fromARGB(255, 24, 33, 63)
                      : const Color.fromARGB(255, 194, 251, 253),
                  fontSize: 35.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Last win',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Today\'s guesses',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Games won',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Current streak',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Max streak',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Average guesses',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 24, 33, 63)
                            : const Color.fromARGB(255, 194, 251, 253),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 24, 33, 63)
                              : const Color.fromARGB(255, 194, 251, 253)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 24, 33, 63)
                              : const Color.fromARGB(255, 194, 251, 253)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 24, 33, 63)
                              : const Color.fromARGB(255, 194, 251, 253)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 24, 33, 63)
                              : const Color.fromARGB(255, 194, 251, 253)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '--',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 24, 33, 63)
                              : const Color.fromARGB(255, 194, 251, 253)),
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
            child: Text(
              'New game from the creator of Globle!',
              style: TextStyle(
                  fontFamily: "Nunito",
                  color: theme.mode == ThemeMode.light
                      ? const Color.fromARGB(255, 24, 33, 63)
                      : const Color.fromARGB(255, 194, 251, 253)),
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
  ),
);
