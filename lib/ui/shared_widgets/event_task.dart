import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/providers/user_provider.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/ui/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatelessWidget {
  final EventDM eventDM;

  EventWidget({super.key, required this.eventDM});

  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = context.userProvider;
    var size = MediaQuery.of(context).size;
    var category = CategoryDM.fromName(eventDM.category);
    return Stack(alignment: Alignment.bottomCenter, children: [
      buildCategoryImage(category),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(eventDM.name), buildFavIcon(context)],
        ),
      ),
      buildEventDate(size)
    ]);
  }

  Positioned buildEventDate(Size size) {
    return Positioned(
        left: size.width * 0.030,
        top: size.height * 0.018,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                eventDM.date.day.toString(),
                style: TextStyle(color: AppColors.blue),
              ),
              Text(DateFormat('MMMM').format(DateTime(0, eventDM.date.month)),
                  style: TextStyle(color: AppColors.blue)),
            ],
          ),
        ));
  }

  Widget buildFavIcon(BuildContext context) {
    var isFavorite = userProvider.currentUser.isFavoriteEvent(eventDM.id);
    return InkWell(
      onTap: () {
        if (isFavorite) {
          userProvider.removeEventFromFavorite(eventDM.id);
        } else {
          userProvider.addEventToFavorite(eventDM.id);
        }
      },
      child: isFavorite
          ? const ImageIcon(
              AssetImage(
                AppAssets.loveActive,
              ),
              color: AppColors.blue,
            )
          : const ImageIcon(
              AssetImage(
                AppAssets.favoriteIconOutlined,
              ),
              color: AppColors.blue,
            ),
    );
  }

  Container buildCategoryImage(CategoryDM category) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      height: 200,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            category.image,
            fit: BoxFit.cover,
          )),
    );
  }
}
