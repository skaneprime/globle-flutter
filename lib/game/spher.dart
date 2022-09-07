import 'package:flutter/material.dart';
import 'package:globe_flutter_android/core/widgets/illustration.dart';

class Sfer extends StatefulWidget {
  const Sfer({Key? key}) : super(key: key);

  @override
  State<Sfer> createState() => _SferState();
}

class _SferState extends State<Sfer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ZIllustration(
        children: const [
          ZCircle(
            diameter: 80,
            stroke: 20,
            color: Color(0xFFCC2255),
          ),
        ],
      ),
    );
  }
}
