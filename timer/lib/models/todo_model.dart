import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class TodoItem extends StatelessWidget {
  String _itemName;
  String _date;
  int _id;
  TodoItem(
    this._itemName,
    this._date,
  );

  TodoItem.map(dynamic ob) {
    this._itemName = ob['itemName'];
    this._date = ob['dateCreated'];
    this._id = ob['id'];
  }
  String get itemName => _itemName;
  String get date => _date;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemName'] = _itemName;
    map['dateCreated'] = _date;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  TodoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map['itemName'];
    this._date = map['dateCreated'];
    this._id = map['id'];
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {}
}
