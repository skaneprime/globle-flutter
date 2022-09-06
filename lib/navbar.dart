import 'package:flutter/material.dart';
import 'package:globe_flutter_android/settings.dart';
import 'package:globe_flutter_android/title.dart';
import 'package:provider/provider.dart';

import 'lid.dart';
import 'main.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) => Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.question_mark,
                    color: theme.mode == ThemeMode.light
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                  tooltip: 'Home',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TitleWidget()),
                    );
                  },
                ),
                Text(
                  'GLOBLE',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Nunito",
                    color: theme.mode == ThemeMode.light
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.analytics,
                        color: theme.mode == ThemeMode.light
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      tooltip: 'Statistics',
                      onPressed: () {
                        showDialog(
                            builder: (BuildContext context) => leadDialog,
                            context: context);
                      },
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: theme.mode == ThemeMode.light
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color.fromARGB(255, 255, 255, 255),
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
                    color: theme.mode == ThemeMode.light
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }
}
