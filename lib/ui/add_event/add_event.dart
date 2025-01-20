import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/category_dm.dart';
import 'package:evently_c13_online/model/event_dm.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/shared_widgets/categories_tabs.dart';
import 'package:evently_c13_online/ui/shared_widgets/custom_button.dart';
import 'package:evently_c13_online/ui/shared_widgets/custom_text_field.dart';
import 'package:evently_c13_online/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AddEvent extends StatefulWidget {
  static const routeName = "add_event";

  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  CategoryDM selectedCategory = CategoryDM.bookingClub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add event"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildCategoryImage(),
            CategoriesTabs(
                showAllTab: false,
                onCategoryClick: (category) {
                  selectedCategory = category;
                }),
            buildTitleTextField(),
            const SizedBox(
              height: 16,
            ),
            buildDescriptionField(),
            const SizedBox(
              height: 16,
            ),
            buildSelectDateRow(),
            const SizedBox(
              height: 16,
            ),
            buildSelectTimeRow(),
            const SizedBox(
              height: 16,
            ),
            buildSelectLocationRow(),
            const SizedBox(
              height: 16,
            ),
            buildAddEventButton()
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

  buildDescriptionField() => Column(
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
                        initialDate: selectedDate,
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
          Text("${selectedDate.hour}:${selectedDate.minute} "),
          const Spacer(),
          InkWell(
              onTap: () async {
                var selectedTime = (await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDate))) ??
                    TimeOfDay.fromDateTime(selectedDate);
                selectedDate = DateTime(selectedDate.year, selectedDate.month,
                    selectedDate.day, selectedTime.hour, selectedTime.minute);
                setState(() {});
              },
              child: const Text("Select Time")),
        ],
      );

  buildSelectLocationRow() => Container();

  buildAddEventButton() => CustomButton(
      title: "Add event",
      onClick: () async {
        EventDM eventDM = EventDM(
            name: titleController.text,
            date: selectedDate,
            ownerId: UserDM.currentUser.id,
            category: selectedCategory.name,
            description: descriptionController.text);
        showLoading(context);
        await addEvent(eventDM);
        hideLoading(context);
        Navigator.pop(context);
      });
}
