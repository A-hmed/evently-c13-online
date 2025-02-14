import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/providers/layout_provider.dart';
import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/add_event/widgets/pick_location_screen.dart';
import 'package:evently_c13_online/ui/shared_widgets/categories_tabs.dart';
import 'package:evently_c13_online/ui/shared_widgets/custom_text_field.dart';
import 'package:evently_c13_online/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const routeName = "add_event";

  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  CategoryDM selectedCategory = CategoryDM.defaultCategories[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
late LayoutProvider provider;
  @override


  @override
  Widget build(BuildContext context) {
     provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCategoryImage(),
                  buildCategoriesTabs(),
                  SizedBox(
                    height: 16,
                  ),
                  buildTitleTextField(),
                  SizedBox(
                    height: 16,
                  ),
                  buildDescriptionTextField(),
                  SizedBox(
                    height: 16,
                  ),
                  buildSelectDateRow(),
                  SizedBox(
                    height: 16,
                  ),
                  buildSelectTimeRow(),
                  SizedBox(
                    height: 16,
                  ),
                  buildLocationRow(),
                  SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PickLocationScreen()));
                  }, child: Text(provider.userLocation == null ? "Pick Location" : "Location: ${provider.userLocation!.latitude} ${provider.userLocation!.longitude}")),
                ],
              ),
            )),
            buildAddEventButton(),
          ],
        ),
      ),
    );
  }

  Container buildCategoryImage() => Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(AppAssets.sport)));

  buildCategoriesTabs() => Container(
    decoration: BoxDecoration(
      color: AppColors.blue,
      borderRadius: BorderRadius.circular(16),
    ),
        child: CategoriesTabs(
            categories: CategoryDM.defaultCategories,
            onCategoryClick: (category) {
              selectedCategory = category;
            }),
      );

  buildDescriptionTextField() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Description"),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
              controller: descriptionController,
              minLines: 3,
              hint: "Description "),
        ],
      );

  buildTitleTextField() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Title"),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
              controller: titleController,
              iconData: EvaIcons.edit,
              hint: "Title"),
        ],
      );

  buildSelectDateRow() => Row(
        children: [
          const Icon(EvaIcons.calendar),
          Text(
              "${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day}"),
          const Spacer(),
          InkWell(
              onTap: () async {
                selectedDate = (await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)))) ??
                    selectedDate;
                setState(() {});
              },
              child: const Text("Choose Date")),

        ],
      );

  buildSelectTimeRow() => Row(
        children: [
          const Icon(EvaIcons.clock),
          SizedBox(
            width: 8,
          ),
          Text("${selectedTime.hour}:${selectedTime.minute}"),
          const Spacer(),
          InkWell(
              onTap: () async {
                selectedTime = await showTimePicker(
                        context: context, initialTime: selectedTime) ??
                    selectedTime;
              },
              child: const Text("Select Time")),
        ],
      );

  buildLocationRow() => Container();

  buildAddEventButton() => FilledButton(
      child: Text("Add event"),
      onPressed: () async {
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute);
        EventDM newEvent = EventDM(
            name: titleController.text,
            date: selectedDate,
            ownerId: UserDM.currentUser.id,
            category: selectedCategory.name,
            description: descriptionController.text,
        lat: provider.userLocation!.latitude,
        lng: provider.userLocation!.longitude
        );
        showLoading(context);
        await addEvent(newEvent);
        hideLoading(context);
        Navigator.pop(context);
      });
}
