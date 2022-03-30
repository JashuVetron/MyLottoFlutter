class NoteModel {
  //Variables
  int? _id;
  late String _title;
  String? _details;
  late String _time;
  late int _priority;

  //constructor
  NoteModel(this._title, this._time, this._priority, [this._details]);
  NoteModel.withId(this._id, this._title, this._time, this._priority,
      [this._details]);

  //getter
  int? get id => _id;
  String get title => _title;
  String? get details => _details;
  String get time => _time;
  int get priority => _priority;

  //setter
  set title(String strV) {
    if (strV.length != 0) {
      this._title = strV;
    }
  }

  set details(String? strV) {
    this._details = strV;
  }

  set priority(int intV) {
    if (intV >= 1 && intV <= 2) {
      this._priority = intV;
    }
  }

  set time(String strV) {
    if (strV.length != 0) {
      this._time = strV;
    }
  }

  //Notemodel To Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['details'] = _details;
    map['time'] = _time;
    map['priority'] = _priority;

    return map;
  }

  //Map object to notemodel
  NoteModel.FromMapToModel(Map<String, dynamic> objM) {
    this._time = objM['time'];
    this._title = objM['title'];
    this._details = objM['details'];
    this._id = objM['id'];
    this._priority = objM['priority'];
  }
}
