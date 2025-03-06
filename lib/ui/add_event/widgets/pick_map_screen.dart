import 'package:evently_c13_online/core/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({super.key});

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  late LocationProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
    provider.getLocation();
    provider.setLocationListener();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: GoogleMap(
                markers: provider.markers,
                onTap: (location){
                  provider.changeLocation(location);
                  Navigator.pop(context);
                },

                initialCameraPosition: provider.cameraPosition,
                onMapCreated: (controller) {
                  provider.mapController = controller;
                },
              ))
        ],
      ),
    );
  }
}
