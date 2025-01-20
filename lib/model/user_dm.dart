

class UserDM {
  static late UserDM currentUser;
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
    favoritesEventsIds = json["favoritesEventsIds"] as List<String>?;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favoritesEventsIds": favoritesEventsIds
    };
  }
}
