import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:flutter/material.dart';

class CategoryDM {
  String name;
  String image;
  IconData icon;

  CategoryDM({required this.name, required this.image, required this.icon});

  static CategoryDM allCategory =
      CategoryDM(name: "all", image: "", icon: Icons.all_inbox);

  static CategoryDM birthDayCategory = CategoryDM(
      name: "BirthDay", image: AppAssets.sport, icon: Icons.mark_chat_unread);

  static CategoryDM sports = CategoryDM(
      name: "Sports",
      image: AppAssets.sport,
      icon: Icons.directions_bike_sharp);

  static CategoryDM bookingClub = CategoryDM(
      name: "Booking Club", image: AppAssets.sport, icon: Icons.cake_outlined);

  static List<CategoryDM> categoriesWithAllCategory = [
    allCategory,
    bookingClub,
    sports,
    birthDayCategory,
  ];
  static List<CategoryDM> categoriesWithoutAllCategory = [
    bookingClub,
    sports,
    birthDayCategory,
  ];
}
