import 'package:evently_c13_online/core/providers/user_provider.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/ui/shared_widgets/event_task.dart';
import 'package:evently_c13_online/ui/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class FavoritesTab extends StatelessWidget {
  FavoritesTab({super.key});

  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = context.userProvider;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for Event',
                prefixIconColor: AppColors.blue,
                hintStyle: TextStyle(color: AppColors.blue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          buildEventsList()
        ],
      ),
    );
  }

  Widget buildEventsList() {
    return FutureBuilder<List<EventDM>>(
        future: getFavoriteEvents(userProvider.currentUser),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return Text("Something went wrong Please try again later");
          } else if (snapshot.hasData) {
            var events = snapshot.data ?? [];
            return events.isEmpty
                ? Text("Your favorites list is empty")
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return EventWidget(eventDM: events[index]);
                      },
                      itemCount: events.length,
                    ),
                  );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        });
  }
}
