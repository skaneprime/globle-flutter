import 'package:flutter/material.dart';
import 'package:globe_flutter_android/lid.dart';
import 'package:globe_flutter_android/title.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GLOBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.question_mark),
                tooltip: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TitleWidget()),
                  );
                },
              ),
              title:
                  const Text('GLOBLE', style: TextStyle(fontFamily: "Nunito")),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.analytics),
                  tooltip: 'Statistics',
                  onPressed: () {
                    showDialog(
                        builder: (BuildContext context) => leadDialog,
                        context: context);
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: () {}),
              ],
            ),
            body: Scaffold(
                body: Column(children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                      'Last win',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
            ]))));
  }
}
