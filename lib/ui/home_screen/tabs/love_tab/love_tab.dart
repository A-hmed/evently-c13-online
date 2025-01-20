import 'package:evently_c13_online/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText:'Search for Event',
              prefixIconColor: AppColors.purple,
              hintStyle: TextStyle(color: AppColors.purple),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.purple,width: 2),
                borderRadius: BorderRadius.circular(20),

              ),
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(itemBuilder: (context, index) {
          //     return EventWidget();
          //
          //   },itemCount: 20,),
          // )
        ],
      ),
    );
  }
}
