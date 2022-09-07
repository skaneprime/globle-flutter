import 'dart:convert';
// import 'dart:ui';
import 'package:globe_flutter_android/game/game.dart';
import 'package:globe_flutter_android/game/navbar.dart';
import 'package:globe_flutter_android/game/spher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/painter.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import 'package:globe_flutter_android/main.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleState();
}

class _TitleState extends State<TitleWidget> {
  final Future<String> countryOutlines =
      rootBundle.loadString("assets/data/country_outlines.json");
  bool isInteracting = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) => MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/cloud.png"),
                  fit: BoxFit.cover,
                  opacity: 0.2),
              gradient: RadialGradient(
                center: Alignment.topCenter,
                colors: [
                  theme.mode == ThemeMode.light
                      ? const Color.fromARGB(178, 63, 201, 255)
                      : const Color.fromARGB(177, 70, 26,
                          100), // Color.fromARGB(178, 63, 201, 255)
                  theme.mode == ThemeMode.light
                      ? const Color.fromARGB(255, 63, 201, 255)
                      : const Color.fromARGB(255, 79, 19, 85)
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const NavbarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Text(
                      'How to play',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 30,
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Text(
                      'Every day, there is a new Mystery Country. Your goal is to guess the mystery country using the fewest number of guesses. Each incorrect guess will appear on the globe with a colour indicating how close it is to the Mystery Country. The hotter the colour, the closer you are to the answer.\n\nFor example, if the Mystery Country is Japan, then the following countries would appear with these colours if guessed:',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<String>(
                        future: countryOutlines,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var contryOutlines =
                                json.decode(snapshot.data.toString());

                            return Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      contryOutlines[0]['name'],
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        color: theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Country(
                                        contryOutlines[0]['name'],
                                        parseSvgPath(contryOutlines[0]['path']),
                                        scale: 0.13,
                                        theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(
                                                255, 255, 221, 107)
                                            : const Color.fromARGB(
                                                255, 191, 245, 255),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      contryOutlines[1]['name'],
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        color: theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Country(
                                        contryOutlines[1]['name'],
                                        parseSvgPath(contryOutlines[1]['path']),
                                        scale: 0.13,
                                        theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(
                                                255, 255, 162, 57)
                                            : const Color.fromARGB(
                                                255, 159, 255, 250),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      contryOutlines[2]['name'],
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        color: theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Country(
                                        contryOutlines[2]['name'],
                                        parseSvgPath(contryOutlines[2]['path']),
                                        scale: 0.13,
                                        theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(
                                                255, 255, 92, 64)
                                            : const Color.fromARGB(
                                                255, 108, 233, 255),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      contryOutlines[3]['name'],
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15,
                                        color: theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Country(
                                        contryOutlines[3]['name'],
                                        parseSvgPath(contryOutlines[3]['path']),
                                        scale: 0.13,
                                        theme.mode == ThemeMode.light
                                            ? const Color.fromARGB(
                                                255, 143, 56, 56)
                                            : const Color.fromARGB(
                                                255, 65, 200, 253),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }

                          return const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                  Text(
                    'A new Mystery Country will be available every day!',
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 15,
                      color: theme.mode == ThemeMode.light
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameWidget()),
                        );

                        // Change Page
                        // isInteracting = !isInteracting;
                      });
                    },
                    child: Sfer(),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      ' Have a question? Check out the FAQ',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Path> parseSvgPathList(contryOutlines) {
    List<Path> path = [parseSvgPath(contryOutlines[0]['path'])];
    for (int i = 1; i < contryOutlines.length; i++) {
      path.add(parseSvgPath(contryOutlines[i]['path']));
    }
    return path;
  }
}
