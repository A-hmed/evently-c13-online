import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  Location location = Location();
  String locationMessage = "";
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {
    Marker(
      markerId: const MarkerId("0"),
      position: const LatLng(37.42796133580664, -122.085749655962),
    )
  };
  LatLng? userLocation;

  Future<void> getLocation() async {
  locationMessage = 'Checking location permission';
  bool locationPermissionGranted = await _getLocationPermission();
  if (!locationPermissionGranted){
    locationMessage = "Location permission not granted";
    notifyListeners();
    return;
  }
  bool locationServiceEnabled = await _serviceEnabled();
  if (!locationServiceEnabled){
    locationMessage = "Location service not enabled";
    notifyListeners();
    return;
  }
  LocationData locationData = await location.getLocation();
  mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  locationMessage = "Location: ${locationData.latitude}, ${locationData.longitude}";
  notifyListeners();



  }


  Future<bool> _getLocationPermission()async {
    var permissionStatus  = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied){
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
 }
Future<bool> _serviceEnabled()async {
  var serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled){
    serviceEnabled = await location.requestService();
  }
  return serviceEnabled;
}
void setLocationListener(){
    location.onLocationChanged.listen((location) {
      changeLocationData (location);
    },);
}

  void changeLocationData(LocationData location) {
    cameraPosition = CameraPosition(
      target: LatLng(location.latitude!, location.longitude!),zoom: 18
    );
    markers = {
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(location.latitude!, location.longitude!),
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }
  void changeLocation (LatLng newLocation){
    userLocation = newLocation;
  }
}