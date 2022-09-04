import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLOBLE',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GLOBLE'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Home',
          onPressed: () {
            // handle the press
          },
        ),
        title: Text(widget.title, style: const TextStyle(fontFamily: "Nunito")),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Statistics',
            onPressed: () {
              // handle the press
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Settings',
            onPressed: () {
              // handle the press
            },
          ),
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
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Every day, there is a new Mystery Country. Your goal is to guess the mystery country using the fewest number of guesses. Each incorrect guess will appear on the globe with a colour indicating how close it is to the Mystery Country. The hotter the colour, the closer you are to the answer.\n\nFor example, if the Mystery Country is Japan, then the following countries would appear with these colours if guessed:',
                      style: TextStyle(fontFamily: "Nunito"),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text("Hi"),
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue,
                                Colors.red,
                              ],
                            )),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text("Hi"),
                          Image.asset("assets/top.svg")
                        ],
                      ),
                      Column(
                        children: const <Widget>[
                          Text("Hi"),
                        ],
                      ),
                      Column(
                        children: const <Widget>[
                          Text("Hi"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
