import 'dart:convert';

import 'package:hive/hive.dart';

import '../model/card_model.dart';

class HiveDB {
  static String DB_NAME = "cards";
  static var box = Hive.box(DB_NAME);

  static Future<void> storeNotes(List<CardModel> card) async {

    List stringList = card.map((note) => jsonEncode(note.toJson()))
        .toList();
    stringList.addAll(loadNotes());

    await box.put("cards", stringList,);
  }
  static List<CardModel> loadNotes() {

    List<String> stringList = box.get("cards",defaultValue: <String>[]) ;

    List<CardModel> noteList = stringList.map((string) => CardModel.fromJson(jsonDecode(string))).toList();
    return noteList;
  }

  static void removeUser() async {
    box.delete('user');
  }

}