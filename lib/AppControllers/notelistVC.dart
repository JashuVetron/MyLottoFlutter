import 'package:flutter/material.dart';
import 'package:my_lotto/AppControllers/NoteAddEdit.dart';
import 'package:my_lotto/Models/NoteModel.dart';
import 'package:my_lotto/Utils/DBHelper.dart';
import 'package:my_lotto/main.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:dio/dio.dart';

class notelistVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _notelistVC();
  }
}

class _notelistVC extends State<notelistVC> {
  int lCount = 2;
  List<NoteModel> noteList = [];
  DBHelper objDBHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    if (noteList.length == 0) {
      noteList = [];
      getNoteList();
    }

    return Scaffold(
      appBar: AppBar(title: Text("All Notes")),
      body: getView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Fab clicked");
          pushToNext(1, -1);
        },
        tooltip: "Add new note",
      ),
    );
  }

  ListView getView() {
    TextStyle? tStyle = Theme.of(context).textTheme.subtitle1;

    var listViewBG = ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: getColorOnPriority(noteList[index].priority),
                  child: getIconsOnPriority(noteList[index].priority)),
              title: Text(noteList[index].title, style: tStyle),
              subtitle: Text(noteList[index].time),
              trailing: Icon(Icons.edit, color: Colors.grey),
              onTap: () {
                pushToNext(2, index);
                debugPrint("item tap at $index");
              },
            ));
      },
    );
    return listViewBG;
  }

  void pushToNext(int intPageIndex, int intEditIndex) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NoteAddEdit(
            (intEditIndex == -1
                ? NoteModel('', '', 2)
                : noteList[intEditIndex]),
            intPageIndex);
      },
    ));
    if (result) {
      getNoteList();
    }
  }

  Color getColorOnPriority(int intP) {
    switch (intP) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  Icon getIconsOnPriority(int intP) {
    switch (intP) {
      case 1:
        return Icon(Icons.library_books);
      case 2:
        return Icon(Icons.menu_book);
      default:
        return Icon(Icons.menu_book);
    }
  }

  void deleteNote(BuildContext context, NoteModel note) async {
    int result = await objDBHelper.deleteNote(note);
    if (result != 0) {
      showSnacBarMsgAlert(context, "Successfully delete");
      getNoteList();
    }
  }

  void showSnacBarMsgAlert(BuildContext context, String strMsg) {
    SnackBar sb = SnackBar(content: Text(strMsg));
    Scaffold.of(context).showSnackBar(sb);
  }

  void getNoteList() {
    final Future<Database> objDatabase = objDBHelper.initDB();
    objDatabase.then((value) {
      Future<List<NoteModel>> arrL = objDBHelper.getList();
      arrL.then((value) {
        if (value.length != 0) {
          setState(() {
            this.noteList = value as List<NoteModel>;
            this.lCount = this.noteList.length;
          });
        }
      });
    });
  }
}
