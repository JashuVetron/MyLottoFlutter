// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:my_lotto/AppControllers/notelistVC.dart';
import './AppControllers/HomeVC.dart';
import 'AppControllers/NoteAddEdit.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.orange),
    title: "First screen list",
    home: notelistVC()));

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: "Simple Interest Calculator",
//     home: FirstPage(),
//     theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.indigo),
//   ));
// }

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage> {
  //variables

  var _Fkey = GlobalKey<FormState>();

  final marPadding = 5.0;
  var arrC = ['USD', 'CAD', 'RUSS', 'INR'];
  var strSC = '';
  var strFinalS = '';

  TextEditingController txtPrinciple = TextEditingController();
  TextEditingController txtRoi = TextEditingController();
  TextEditingController txtTems = TextEditingController();

  @override
  void initState() {
    super.initState();
    strSC = arrC.last;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
          key: _Fkey,
          child: Padding(
            padding: EdgeInsets.all(marPadding * 2),
            child: Column(
              children: [
                getTopImage(),
                Padding(
                    padding:
                        EdgeInsets.only(top: marPadding, bottom: marPadding),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: txtPrinciple,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter value first';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          hintText: "Enter principal amount",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: marPadding, bottom: marPadding),
                    child: TextField(
                      controller: txtRoi,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: "Enter Percentage",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    )),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: marPadding, bottom: marPadding),
                            child: TextField(
                              style: textStyle,
                              controller: txtTems,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Term",
                                  hintText: "Enter Years",
                                  labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ))),
                    Container(
                      width: marPadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton(
                      alignment: Alignment.center,
                      items: arrC.map((String strV) {
                        return DropdownMenuItem(
                          child: Text(
                            strV,
                            style: textStyle,
                          ),
                          value: strV,
                        );
                      }).toList(),
                      onChanged: (strV) {
                        setState(() {
                          strSC = "$strV";
                        });
                      },
                      value: strSC,
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: marPadding, bottom: marPadding),
                  child: Row(
                    children: [
                      Expanded(
                          child: MaterialButton(
                              elevation: 5,
                              color: Colors.blue,
                              child: Text(
                                'Calcluate',
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_Fkey.currentState!.validate()) {
                                    strFinalS = calculatePrice();
                                  }
                                });
                              })),
                      Container(
                        width: marPadding * 2,
                      ),
                      Expanded(
                          child: MaterialButton(
                              elevation: 10,
                              color: Colors.black38,
                              child: Text(
                                'Reset',
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  resetprice();
                                });
                              }))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: marPadding * 10, bottom: marPadding),
                  child: Text(
                    strFinalS,
                    style: textStyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget getTopImage() {
    AssetImage aI = AssetImage("images/image_green_ball.png");
    Image img = Image(
      image: aI,
      width: 125,
      height: 125,
    );
    return Container(
      child: img,
      margin: EdgeInsets.all(marPadding * 10),
    );
  }

  String calculatePrice() {
    double vP = double.parse(txtPrinciple.text);
    double vR = double.parse(txtRoi.text);
    double vT = double.parse(txtTems.text);

    double vF = vP + (vP * vR * vT) / 100;
    return 'Your $vP $strSC will be $vF $strSC after $vT';
  }

  void resetprice() {
    txtPrinciple.text = '';
    txtRoi.text = '';
    txtTems.text = '';
    strFinalS = '';
    strSC = arrC.last;
  }
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: "My app1",
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text("Our First list"),
//       ),
//       body: getList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           debugPrint("Tap on fAB");
//         },
//         child: Icon(Icons.add_a_photo),
//         tooltip: "CLick on it",
//       ),
//     ),
//   ));
// }

class betPlaced extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _betPlaced();
  }
}

class _betPlaced extends State<betPlaced> {
//Properties
  String strValue = "";
  var arrGames = ["5/11", "5/90", '11/90'];
  String _strSelecetdGame = "5/11";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My First Statefull widget"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  strValue = value;
                });
              },
            ),
            Container(
              child: DropdownButton<String>(
                items: arrGames.map((String strV) {
                  return DropdownMenuItem<String>(
                    value: strV,
                    child: Text('Game $strV'),
                  );
                }).toList(),
                onChanged: (value) {
                  ssForDropDown(value!);
                },
                value: _strSelecetdGame,
              ),
              alignment: Alignment.centerLeft,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text("Your bet held in : $strValue")
          ],
        ),
      ),
    );
  }

  void ssForDropDown(String strV) {
    setState(() {
      _strSelecetdGame = strV;
    });
  }
}

Widget getList() {
  var arrStrs = List<String>.generate(100, (index) => "Game $index");
  var listV = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(Icons.arrow_right),
      title: Text(arrStrs[index]),
      onTap: () => showSB(context, arrStrs[index]),
    );
  });
  return listV;
}

void showSB(BuildContext context, String strIndex) {
  var sB = SnackBar(
    content: Text("Cool deleted"),
    action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          debugPrint("Undo item $strIndex");
        }),
  );
  Scaffold.of(context).showSnackBar(sB);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: "Hey Its Our App",
    //     home: Scaffold(
    //         appBar: AppBar(
    //           title: Text("First Screen1"),
    //         ),
    //         body: first_vc()));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hi 1",
      home: HomeVC(),
    );
  }
}
