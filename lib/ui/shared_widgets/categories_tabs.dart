import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  final bool showAllTab;
  final Function(CategoryDM) onCategoryClick;

  const CategoriesTabs(
      {super.key, this.showAllTab = true, required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: DefaultTabController(
        length: showAllTab ? 4 : 3,
        child: TabBar(
            onTap: (index) {
              onCategoryClick(showAllTab
                  ? CategoryDM.categoriesWithAllCategory[index]
                  : CategoryDM.categoriesWithoutAllCategory[index]);
            },
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.white),
              color: AppColors.white,
            ),
            isScrollable: true,
            dividerColor: Colors.transparent,
            // unselectedLabelColor: AppColors.white,
            // labelColor: AppColors.purple,
            unselectedLabelStyle: TextStyle(color: AppColors.white),
            labelStyle: TextStyle(color: AppColors.purple),
            tabs: [
              if (showAllTab)
                buildTabView(
                    "All",
                    Icon(
                      Icons.compass_calibration_outlined,
                    )),
              buildTabView(
                  "Book Club",
                  Icon(
                    Icons.mark_chat_unread,
                  )),
              buildTabView(
                  "Sport",
                  Icon(
                    Icons.directions_bike_sharp,
                  )),
              buildTabView(
                  "Birthday",
                  Icon(
                    Icons.cake_outlined,
                  )),
            ]),
      ),
    );
  }

  Tab buildTabView(String title, Widget icon) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 8,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Decoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.white),
      borderRadius: BorderRadius.circular(50),
    );
  }
}
