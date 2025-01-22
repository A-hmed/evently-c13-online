import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_assets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
              decoration: const BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64),
                ),
              ),
              child: Row(children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                      topRight: Radius.circular(1000),
                    ),
                    child: Image.asset(
                      AppAssets.sport,
                      fit: BoxFit.cover,
                      width: 124,
                      height: 124,
                    )),
                const SizedBox(
                  width: 16,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yousef',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'yousef@gmail.com',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ])),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Language',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    bottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.blue, width: 2),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'English',
                          style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColors.blue,
                          size: 34,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Theme',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    bottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.blue, width: 2),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Light',
                          style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColors.blue,
                          size: 34,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.white,
                      size: 34,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  void bottomSheet(){
    showModalBottomSheet(context: context, builder: (context) => Container(),);
  }
}
