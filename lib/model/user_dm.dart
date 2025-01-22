

class UserDM {
  late String id;
  late String name;
  late String email;
  late List<String>? favoritesEventsIds;

  UserDM(
      {required this.id,
      required this.name,
      required this.email,
      this.favoritesEventsIds});

  UserDM.fromJson(Map<Object, Object?> json) {
    id = json["id"] as String;
    email = json["email"] as String;
    name = json["name"] as String;
    List<dynamic>? events = json["favoritesEventsIds"] as List<dynamic>?;
    favoritesEventsIds = events?.map((event) => event.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favoritesEventsIds": favoritesEventsIds
    };
  }

  bool isFavoriteEvent(String eventId) {
    return favoritesEventsIds?.contains(eventId) ?? false;
  }
}
