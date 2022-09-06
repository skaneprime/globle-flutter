import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'navbar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, theme, child) {
      return MaterialApp(
        title: 'GLOBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
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
                      : const Color.fromARGB(
                          176, 39, 14, 56), // Color.fromARGB(178, 63, 201, 255)
                  theme.mode == ThemeMode.light
                      ? const Color.fromARGB(255, 63, 201, 255)
                      : const Color.fromARGB(255, 48, 12, 51)
                ],
              ),
            ),
            child: Column(
              children: [
                const NavbarWidget(),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Language',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: theme.mode == ThemeMode.light
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 180.0),
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'English',
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  color: theme.mode == ThemeMode.light
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : const Color.fromARGB(
                                          255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Day Theme',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: theme.mode == ThemeMode.light
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 195.0),
                            alignment: Alignment.centerRight,
                            child: SwitchButton(
                              isSwitched:
                                  theme.mode == ThemeMode.light ? true : false,
                              onPressed: (val) {
                                theme.toggleMode();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rainbow Off',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: theme.mode == ThemeMode.light
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 190.0),
                            alignment: Alignment.centerRight,
                            child: SwitchButton(onPressed: (_) {}),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Colour Blind Mode Off',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: theme.mode == ThemeMode.light
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 130.0),
                            alignment: Alignment.centerRight,
                            child: SwitchButton(onPressed: (_) {}),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cities',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: theme.mode == ThemeMode.light
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 235.0),
                            alignment: Alignment.centerRight,
                            child: SwitchButton(onPressed: (_) {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SwitchButton extends StatefulWidget {
  final void Function(bool) onPressed;
  bool isSwitched;
  SwitchButton({super.key, required this.onPressed, this.isSwitched = false});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSwitched,
      onChanged: (value) {
        setState(() {
          widget.isSwitched = value;
          widget.onPressed(widget.isSwitched);
          // print(isSwitched);
        });
      },

      // activeTrackColor: Colors.lightGreenAccent,
      // activeColor: Colors.green,
    );
  }
}
