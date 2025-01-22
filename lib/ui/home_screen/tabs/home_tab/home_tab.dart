import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/ui/shared_widgets/categories_tabs.dart';
import 'package:evently_c13_online/ui/shared_widgets/event_task.dart';
import 'package:evently_c13_online/ui/utils/context_extensions.dart';
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
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  buildWelcomeText(),
                  const SizedBox(
                    height: 5,
                  ),
                  buildLocationText(),
                  CategoriesTabs(
                    categories: CategoryDM.categoriesWithAllCategory,
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
    return const Row(
      children: [
        ImageIcon(
          AssetImage(AppAssets.mapIcon),
          color: AppColors.white,
        ),
        Text('Cairo , Egypt', style: TextStyle(color: AppColors.white)),
      ],
    );
  }

  Row buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              'Welcome Back ✨',
              style: TextStyle(color: AppColors.white),
            ),
            Text(context.userProvider.currentUser.name,
                style: const TextStyle(color: AppColors.white)),
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
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Expanded buildEventsListView() {
    return Expanded(
      child: StreamBuilder<List<EventDM>>(
        stream: getEventsByCategory(selectedCategory.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(
                "Error While LOADING EVENTS: ${snapshot.error}: ${snapshot.stackTrace}");
            return const Text("Error");
          } else if (snapshot.hasData) {
            var eventsList = snapshot.data ?? [];
            return eventsList.isEmpty
                ? const Center(
                    child: Text(
                    "Currently There is no available events",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: AppColors.blue),
                  ))
                : ListView.builder(
                    itemBuilder: (context, index) => EventWidget(
                      eventDM: eventsList[index],
                    ),
                    itemCount: eventsList.length,
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
