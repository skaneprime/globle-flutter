import 'package:flutter/material.dart';
import 'package:globe_flutter_android/settings.dart';
import 'package:globe_flutter_android/title.dart';

import 'lid.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
      child: Column(
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
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
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
          )
        ],
      ),
    );
  }
}
