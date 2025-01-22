import 'package:cloud_firestore/cloud_firestore.dart';

class EventDM {
  late String id;
  late String name;
  late DateTime date;
  late String ownerId;
  late int? lat;
  late int? lng;
  late String category;
  late String description;

  EventDM(
      {required this.name,
      required this.date,
      required this.ownerId,
      this.lat,
      this.lng,
      required this.category,
      required this.description});

  EventDM.fromJson(Map json, {this.id = ""}) {
    name = json["name"];
    Timestamp timestamp = json["date"];
    date = timestamp.toDate();
    ownerId = json["ownerId"];
    lat = json["lat"];
    lng = json["lng"];
    category = json["category"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["date"] = date;
    json["ownerId"] = ownerId;
    json["lat"] = lat;
    json["lng"] = lng;
    json["category"] = category;
    json["description"] = description;
    return json;
  }
}
