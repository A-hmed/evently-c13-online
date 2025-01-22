import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/model/user_dm.dart';

///Event Features

Stream<List<EventDM>> getEventsByCategory(String category) {
  if (category == CategoryDM.allCategory.name) {
    var eventsCollection = FirebaseFirestore.instance.collection("events");
    Stream<QuerySnapshot> collectionSnapshot = eventsCollection
        //.where("category", isEqualTo: category).
        .snapshots();
    Stream<List<EventDM>> eventsStream =
        collectionSnapshot.map((querySnapshot) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<EventDM> events = documents.map(documentSnapshotToEventDM).toList();
      return events;
    });
    return eventsStream;
  } else {
    var eventsCollection = FirebaseFirestore.instance.collection("events");
    Stream<QuerySnapshot> collectionSnapshot =
        eventsCollection.where("category", isEqualTo: category).snapshots();
    Stream<List<EventDM>> eventsStream =
        collectionSnapshot.map((querySnapshot) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<EventDM> events = documents.map(documentSnapshotToEventDM).toList();
      return events;
    });

    return eventsStream;
  }
}

EventDM documentSnapshotToEventDM(QueryDocumentSnapshot doc) {
  Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
  return EventDM.fromJson(json, id: doc.id);
}

Future<void> addEvent(EventDM event) {
  var eventsCollection = FirebaseFirestore.instance.collection("events");
  return eventsCollection.add(event.toJson());
}

Future<List<EventDM>> getFavoriteEvents(UserDM currentUser) async {
  List<String> userFavoritesEvents = currentUser.favoritesEventsIds ?? [];
  if (userFavoritesEvents.isEmpty) return [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("events")
      .where(FieldPath.documentId, whereIn: userFavoritesEvents)
      .get();
  return snapshot.docs.map(documentSnapshotToEventDM).toList();
}

//
///Assignment // Future<void> updateEvent(EventDM newEvent){}
//
// ///User Features
Future<void> addEventToFavorites(String eventId, String userId) async {
  var usersCollection = FirebaseFirestore.instance.collection("users");
  var userDoc = usersCollection.doc(userId);
  userDoc.update({
    "favoritesEventsIds": FieldValue.arrayUnion([eventId])
  });
}

Future<void> removeEventFromFavorites(String eventId, String userId) async {
  var usersCollection = FirebaseFirestore.instance.collection("users");
  var userDoc = usersCollection.doc(userId);
  userDoc.update({
    "favoritesEventsIds": FieldValue.arrayRemove([eventId])
  });
}

Future<void> createUserInFirestore(UserDM userDm) {
  // UserDM(id: "1", name: "ahmed", email: "ahmed@gmail.com", favoritesEventsIds: ["1"])???
  // {"id": "1", "name": "ahmed", "email": "ahmed@gmail.com", "favoritesEventsIds": ["1"]}
  var usersCollection = FirebaseFirestore.instance.collection("users");
  DocumentReference newUserDoc = usersCollection.doc(userDm.id);
  return newUserDoc.set(userDm.toJson());

  ///Create an empty document with existing id
  /// usersCollection.add(userDm.toJson()); ///Creates a document with an auto generated id

  ///Add doc
  // usersCollection.add(Json);
  // usersCollection.get() ->>Json
}

Future<UserDM> getUserFromFirestore(String id) async {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  ///Create collection if it does not exist
  ///Or Gets the collection if it exists

  DocumentReference userDoc = usersCollection.doc(id);

  ///Create empty document if id does not exits and it gets the documents if it exists
  DocumentSnapshot userSnapshot = await userDoc.get();
  Map<Object, Object?> json = userSnapshot.data() as Map<Object, Object?>;
  return UserDM.fromJson(json);
  // return UserDM(id: json["id"], name: json["name"],
  //     email: json["email"], favoritesEventsIds: json["favoritesEventsIds"]);
}

///JSON ??? Java script object notation
