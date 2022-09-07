// import 'dart:convert';
// import 'dart:ui';
import 'package:globe_flutter_android/search.dart';
import 'package:globe_flutter_android/title.dart';

import '../planet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../lid.dart';
// import '../painter.dart';
import '../settings.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cloud.png"),
                fit: BoxFit.cover,
                opacity: 0.2),
            gradient: RadialGradient(
              center: Alignment.topCenter,
              colors: [
                Color.fromARGB(178, 63, 201, 255),
                Color.fromARGB(255, 63, 201, 255)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        alignment: Alignment.center,
                        icon: const Icon(Icons.question_mark,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        tooltip: 'Home',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TitleWidget()),
                          );
                        },
                      ),
                      const Text(
                        'GLOBLE',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "Nunito",
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.analytics,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            tooltip: 'Statistics',
                            onPressed: () {
                              showDialog(
                                  builder: (BuildContext context) => leadDialog,
                                  context: context);
                            },
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.settings,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              tooltip: 'Settings',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Settings()),
                                );
                              }),
                        ],
                      ),
                    ]),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height / 2,
                      height: 5,
                      child: Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Change Page
                      isInteracting = !isInteracting;
                    });
                  },
                  child: Stack(
                    children: [
                      Planet(
                        interative: isInteracting,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(alignment: Alignment.center, child: Search()),
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
