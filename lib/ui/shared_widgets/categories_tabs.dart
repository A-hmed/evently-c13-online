import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  final Function(CategoryDM) onCategoryClick;
  final List<CategoryDM> categories;

  const CategoriesTabs(
      {super.key, required this.onCategoryClick, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      child: DefaultTabController(
        length: categories.length,
        child: TabBar(
            onTap: (index) {
              onCategoryClick(categories[index]);
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
            labelStyle: TextStyle(color: AppColors.blue),
            tabs: categories.map(categoryToTab).toList()),
      ),
    );
  }

  Tab categoryToTab(CategoryDM category) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon),
            const SizedBox(
              width: 8,
            ),
            Text(category.name),
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
