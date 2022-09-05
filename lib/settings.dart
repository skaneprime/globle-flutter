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
                MaterialPageRoute(builder: (context) => const TitleWidget()),
              );
            },
          ),
          title: const Text('GLOBLE', style: TextStyle(fontFamily: "Nunito")),
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
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Language',
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 180.0),
                        alignment: Alignment.centerRight,
                        child: const ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'English',
                            style: TextStyle(fontFamily: "Nunito"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Day Theme',
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 195.0),
                        alignment: Alignment.centerRight,
                        child: const SwitchButton(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Rainbow Off',
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 190.0),
                        alignment: Alignment.centerRight,
                        child: const SwitchButton(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Colour Blind Mode Off',
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 130.0),
                        alignment: Alignment.centerRight,
                        child: const SwitchButton(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Cities',
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 235.0),
                        alignment: Alignment.centerRight,
                        child: const SwitchButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          // print(isSwitched);
        });
      },

      // activeTrackColor: Colors.lightGreenAccent,
      // activeColor: Colors.green,
    );
  }
}
