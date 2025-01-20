import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/home_screen/tabs/home_tab/widget/event_task.dart';
import 'package:evently_c13_online/ui/shared_widgets/categories_tabs.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CategoryDM selectedCategory = CategoryDM.allCategory;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SafeArea(
              child: Container(
            width: double.infinity,
            height: 174,
            decoration: const BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  buildWelcomeText(),
                  SizedBox(
                    height: 5,
                  ),
                  buildLocationText(),
                  CategoriesTabs(
                    onCategoryClick: (category) {
                      selectedCategory = category;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          )),
          buildEventsListView()
        ],
      ),
    );
  }

  Row buildLocationText() {
    return Row(
      children: [
        ImageIcon(
          AssetImage(AppAssets.mapIcon),
          color: AppColors.white,
        ),
        const Text('Cairo , Egypt', style: TextStyle(color: AppColors.white)),
      ],
    );
  }

  Row buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Welcome Back ✨',
              style: TextStyle(color: AppColors.white),
            ),
            Text(UserDM.currentUser!.name,
                style: TextStyle(color: AppColors.white)),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.sunny,
          color: AppColors.white,
          size: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: const Text(
            'EN',
            style:
                TextStyle(color: AppColors.purple, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Expanded buildEventsListView() {
    return Expanded(
      child: FutureBuilder<List<EventDM>>(
        future: getEventsByCategory(selectedCategory.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(
                "Error While LOADING EVENTS: ${snapshot.error}: ${snapshot.stackTrace}");
            return Text("Error");
          } else if (snapshot.hasData) {
            var eventsList = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) => EventWidget(
                eventDM: eventsList[index],
              ),
              itemCount: eventsList.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
