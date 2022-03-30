import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_lotto/Models/NoteModel.dart';
import 'package:my_lotto/Utils/DBHelper.dart';

class NoteAddEdit extends StatefulWidget {
  //Variables
  int intPageIndex;
  NoteModel objNote;

  NoteAddEdit(this.objNote, this.intPageIndex);

  @override
  State<StatefulWidget> createState() {
    int intPageIndex;
    NoteModel objNote;

    return _NoteAddEdit(this.objNote, this.intPageIndex);
  }
}

class _NoteAddEdit extends State<NoteAddEdit> {
  //variables
  int intPageIndex;
  NoteModel objNote;

  _NoteAddEdit(this.objNote, this.intPageIndex);
  DBHelper objDBHelper = DBHelper();
  static var _priority = ["High", "Low"];
  var strSelectedPriority = _priority.last;

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDetail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? tStyle = Theme.of(context).textTheme.subtitle1;

    //set data
    txtTitle.text = objNote.title;
    if (intPageIndex == 2) {
      txtDetail.text = objNote.details!;
    }

    strSelectedPriority =
        objNote.priority == 1 ? _priority.first : _priority.last;

    return
        // WillPopScope(
        //     onWillPop: () => popToBack(),
        //     child:
        Scaffold(
      appBar: AppBar(
        title: Text(intPageIndex == 1 ? "Add Note" : "Edit Note"),
        leading: IconButton(
          onPressed: () {
            popToBack();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView(
            children: [
              ListTile(
                leading: DropdownButton(
                  items: _priority.map((String strV) {
                    return DropdownMenuItem<String>(
                      value: strV,
                      child: Text(strV),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      strSelectedPriority = "$value";
                      objNote.priority = (value == _priority.first ? 1 : 2);
                      debugPrint("priority value is $value");
                    });
                  },
                  style: tStyle,
                  value: strSelectedPriority,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: txtTitle,
                  style: tStyle,
                  onChanged: (value) {
                    debugPrint("Value is $value");
                    objNote.title = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: tStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: txtDetail,
                  style: tStyle,
                  onChanged: (value) {
                    debugPrint("Value is $value");
                    objNote.details = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Detail",
                      labelStyle: tStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          debugPrint("click");
                          saveData(context);
                        });
                      },
                      child: Text(
                        "Save",
                        textScaleFactor: 1.25,
                      ),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                    )),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                        child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          debugPrint(" Delete click");
                          deleteData();
                        });
                      },
                      child: Text(
                        "Delete",
                        textScaleFactor: 1.25,
                      ),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                    ))
                  ],
                ),
              )
            ],
          )),
    );
  }

  void popToBack() {
    Navigator.pop(context, true);
  }

  void saveData(BuildContext context) async {
    int result;
    objNote.time = DateFormat.yMd().format(DateTime.now());
    if (intPageIndex == 1) {
      //add
      result = await objDBHelper.addNote(objNote);
    } else {
      //edit
      result = await objDBHelper.updateNote(objNote);
    }

    if (result != 0) {
      //success
      print("Success");
      // shoAlertMessage("Success", "Note saved successfully", context);
    } else {
      //failure
      print("Failure");
      // shoAlertMessage("Failure", "Note not saved!!!", context);
    }
    popToBack();
  }

  void deleteData() async {
    if (intPageIndex == 1) {
      //new
    } else {
      int result = await objDBHelper.deleteNote(objNote);
      if (result != 0) {
        print("Note deleted successfully");
        // shoAlertMessage("Delete", "Note deleted successfully", context);
      } else {
        print("No note deleted!!!");
        // shoAlertMessage("Failure", "No note deleted!!!", context);
      }
    }
    popToBack();
  }

  void shoAlertMessage(String strTitle, String strMsg, BuildContext context) {
    var objAD = AlertDialog(
      content: Text(strMsg),
      title: Text(strTitle),
    );
    showDialog(context: context, builder: (BuildContext context) => objAD);
  }
}
