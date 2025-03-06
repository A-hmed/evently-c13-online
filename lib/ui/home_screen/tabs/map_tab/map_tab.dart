import 'package:evently_c13_online/core/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late LocationProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
    provider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Consumer<LocationProvider>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: FloatingActionButton(onPressed: (){
            provider.setLocationListener();
          },child: const Icon(Icons.gps_fixed_outlined),),
          body: Column(
            children: [
              Expanded(
                  child: GoogleMap(
                    markers: provider.markers,

                initialCameraPosition: provider.cameraPosition,
                onMapCreated: (controller) {
                  provider.mapController = controller;
                },
              ))
            ],
          ),
        );
      },
    );
  }
}
