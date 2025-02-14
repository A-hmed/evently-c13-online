import 'package:evently_c13_online/core/providers/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late LayoutProvider provider;
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
    provider.getLocation();
    provider.setLocationListener();
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
      ),
      body:Column(
      children: [
        Expanded(
            child: GoogleMap(
              onTap: (location) {
                provider.changeLocation(location);
                Navigator.pop(context);
              },
              initialCameraPosition: provider.cameraPosition,
              mapType: MapType.normal,
              markers: provider.markers,
              onMapCreated: (controller) {
                provider.mapController = controller;

              },
            ))
      ],
    ),);
  }
}
