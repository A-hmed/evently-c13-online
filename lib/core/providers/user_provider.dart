import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late UserDM currentUser;

  updateCurrentUser(UserDM newUser) {
    currentUser = newUser;
    notifyListeners();
  }

  addEventToFavorite(String eventId) async {
    await addEventToFavorites(eventId, currentUser.id);
    currentUser = await getUserFromFirestore(currentUser.id);
    notifyListeners();
  }

  removeEventFromFavorite(String eventId) async {
    await removeEventFromFavorites(eventId, currentUser.id);
    currentUser = await getUserFromFirestore(currentUser.id);
    notifyListeners();
  }
}
