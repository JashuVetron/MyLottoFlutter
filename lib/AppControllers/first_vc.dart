import 'dart:math';

import 'package:flutter/material.dart';

class first_vc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.lightBlue,
      child: Center(
        child: Text(
          genLuckNo(),
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
      ),
    );
  }

  String genLuckNo() {
    var intRandom = Random();
    return "Hi Jass Potter ${intRandom.nextInt(100)}";
  }
}
