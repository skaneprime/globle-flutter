import 'package:flutter/material.dart';
import 'package:globe_flutter_android/lid.dart';
import 'package:globe_flutter_android/settings.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleState();
}

class _TitleState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.question_mark),
            tooltip: 'Home',
            onPressed: () {},
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                }),
          ],
        ),
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
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(178, 255, 196, 87),
                  Color.fromARGB(0, 255, 196, 87)
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Every day, there is a new Mystery Country. Your goal is to guess the mystery country using the fewest number of guesses. Each incorrect guess will appear on the globe with a colour indicating how close it is to the Mystery Country. The hotter the colour, the closer you are to the answer.\n\nFor example, if the Mystery Country is Japan, then the following countries would appear with these colours if guessed:',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Text("Hi"),
                            Image.asset(
                              "assets/top.png",
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Text("Hi"),
                            Image.asset(
                              "assets/top.png",
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Text("Hi"),
                            Image.asset(
                              "assets/top.png",
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Text("Hi"),
                            Image.asset(
                              "assets/top.png",
                              height: 100,
                              width: 100,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Text(
                    'A new Mystery Country will be available every day!',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                  const SizedBox(
                    height: 150,
                    width: 100,
                  ),
                  const Text(
                    'Click the globe to play!',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                  const SizedBox(
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Have a question? Check out the FAQ',
                      style: TextStyle(fontFamily: "Nunito"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
