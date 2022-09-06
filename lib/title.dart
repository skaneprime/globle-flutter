import 'dart:convert';
// import 'dart:ui';
import 'package:globe_flutter_android/game.dart';
import 'package:globe_flutter_android/navbar.dart';

import '../planet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../painter.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const NavbarWidget(),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    'How to play',
                    style: TextStyle(fontFamily: "Nunito", fontSize: 30),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    'Every day, there is a new Mystery Country. Your goal is to guess the mystery country using the fewest number of guesses. Each incorrect guess will appear on the globe with a colour indicating how close it is to the Mystery Country. The hotter the colour, the closer you are to the answer.\n\nFor example, if the Mystery Country is Japan, then the following countries would appear with these colours if guessed:',
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 15,
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
                                  Text(contryOutlines[0]['name']),
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Country(
                                      contryOutlines[0]['name'],
                                      parseSvgPath(contryOutlines[0]['path']),
                                      scale: 0.13,
                                      const Color.fromARGB(255, 255, 221, 107),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(contryOutlines[1]['name']),
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Country(
                                      contryOutlines[1]['name'],
                                      parseSvgPath(contryOutlines[1]['path']),
                                      scale: 0.13,
                                      const Color.fromARGB(255, 255, 162, 57),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(contryOutlines[2]['name']),
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Country(
                                      contryOutlines[2]['name'],
                                      parseSvgPath(contryOutlines[2]['path']),
                                      scale: 0.13,
                                      const Color.fromARGB(255, 255, 92, 64),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(contryOutlines[3]['name']),
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Country(
                                      contryOutlines[3]['name'],
                                      parseSvgPath(contryOutlines[3]['path']),
                                      scale: 0.13,
                                      const Color.fromARGB(255, 143, 56, 56),
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
                const Text(
                  'A new Mystery Country will be available every day!',
                  style: TextStyle(fontFamily: "Nunito"),
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
                    child: Planet(
                      interative: isInteracting,
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                    )
                    // !isInteracting
                    //     ? Planet(
                    //         // key: const Key('Planet1'),
                    //         interative: false,
                    //       )
                    //     : Planet(
                    //         key: const Key('Planet2'),
                    //         interative: true,
                    //       ),
                    ),

                /*FutureBuilder<String>(
                      future: countryOutlines,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var contryOutlines =
                              json.decode(snapshot.data.toString());

                          return Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: World(
                                    parseSvgPathList(contryOutlines),
                                    scale: 0.13,
                                    const Color.fromARGB(255, 143, 56, 56),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        );
                      }),*/
                // const Text(
                //   'Click the globe to play!',
                //   style: TextStyle(fontFamily: "Nunito"),
                // ),
                // const SizedBox(
                //   // height: 100,
                //   width: 100,
                // ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    ' Have a question? Check out the FAQ',
                    style: TextStyle(fontFamily: "Nunito"),
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
