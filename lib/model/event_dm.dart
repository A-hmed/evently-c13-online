import 'package:cloud_firestore/cloud_firestore.dart';

class EventDM {
  late String name;
  late DateTime date;
  late String ownerId;
  late double? lat;
  late double? lng;
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

  EventDM.fromJson(Map json) {
    name = json["name"];
    Timestamp timeStamp = json["date"];
    date = timeStamp.toDate();
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
