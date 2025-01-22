import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:flutter/material.dart';

class CategoryDM {
  static const birthDayCategoryName = "BirthDay";
  static const bookingClubCategoryName = "Booking Club";
  static const sportsCategoryName = "Sports";
  String name;
  String image;
  IconData icon;

  CategoryDM({required this.name, required this.image, required this.icon});

  factory CategoryDM.fromName(String name) {
    switch (name) {
      case birthDayCategoryName:
        return birthDayCategory;
      case bookingClubCategoryName:
        return bookingClubCategory;
      default:
        return sportsCategory;
    }
  }

  static CategoryDM allCategory =
      CategoryDM(name: "all", image: "", icon: Icons.all_inbox);

  static CategoryDM birthDayCategory = CategoryDM(
      name: "BirthDay",
      image: AppAssets.birthday,
      icon: Icons.mark_chat_unread);

  static CategoryDM sportsCategory = CategoryDM(
      name: "Sports",
      image: AppAssets.sport,
      icon: Icons.directions_bike_sharp);

  static CategoryDM bookingClubCategory = CategoryDM(
      name: "Booking Club",
      image: AppAssets.bookingClub,
      icon: Icons.cake_outlined);

  static List<CategoryDM> categoriesWithAllCategory = [
    allCategory,
    bookingClubCategory,
    sportsCategory,
    birthDayCategory,
  ];

  static List<CategoryDM> categoriesWithoutAllCategory = [
    bookingClubCategory,
    sportsCategory,
    birthDayCategory,
  ];
}
