import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/painter.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Future<String> countryOutlines =
      rootBundle.loadString("assets/data/country_outlines.json");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.play_circle_outline_outlined),
            hintText: 'Enter',
            labelText: 'Countrty',
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
        ),
        FutureBuilder<String>(
            future: countryOutlines,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var contryOutlines = json.decode(snapshot.data.toString());

                return Column(
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
                );
              }

              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }),
        // const Text(
        //   'Click the globe to play!',
        //   style: TextStyle(fontFamily: "Nunito"),
        // ),
        // const SizedBox(
        //   // height: 100,
        //   width: 100,
        // ),
      ],
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
