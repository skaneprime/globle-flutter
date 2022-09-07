// import 'dart:convert';
// import 'dart:ui';
import 'package:globe_flutter_android/navbar.dart';
import 'package:globe_flutter_android/search.dart';
import 'package:globe_flutter_android/title.dart';
import 'package:provider/provider.dart';

import '../planet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../lid.dart';
// import '../painter.dart';
import '../settings.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import 'main.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<GameWidget> createState() => _GameState();
}

class _GameState extends State<GameWidget> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const NavbarWidget(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Change Page
                      isInteracting = !isInteracting;
                    });
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: const Search()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Planet(
                          interative: isInteracting,
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
