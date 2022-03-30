import 'package:flutter/material.dart';

class HomeVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          color: Colors.cyan,
          child: Column(children: [
            Row(children: [
              Container(
                child: AImages(),
                padding: EdgeInsets.only(left: 10),
              ),
              const Expanded(
                  child: Text("5/90",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 50,
                          color: Colors.white,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic))),
              const Expanded(
                  child: Text("Win 5 no from 90 no",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic)))
            ]),
            Row(children: [
              Container(
                child: AImages(),
                padding: EdgeInsets.only(left: 10),
              ),
              const Expanded(
                  child: Text("5/11",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 50,
                          color: Colors.white,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic))),
              const Expanded(
                  child: Text("Win 5 no from 11 no",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic)))
            ]),
            Container(
              child: buttonRised(),
              padding: EdgeInsets.only(top: 20),
            )
          ])),
    );
  }
}

class AImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage aImage = AssetImage("images/image_green_ball.png");
    Image imgBG = Image(image: aImage);
    return Container(
      child: imgBG,
      width: 50,
      height: 50,
    );
  }
}

class buttonRised extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      child: MaterialButton(
          child: Text("Play game"),
          color: Colors.orange,
          elevation: 5,
          onPressed: () => btnRisedAction(context)),
    );
  }

  void btnRisedAction(BuildContext context) {
    var alertD = AlertDialog(
      title: Text("App Lotto"),
      content: Text("Enjoy your game"),
    );

    showDialog(context: context, builder: (BuildContext context) => alertD);
  }
}
