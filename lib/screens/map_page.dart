import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void calDistance(Position pos) {
    // จุดที่ 1 (ตัวอย่าง ใช้จาก Position)
    double lat1 = pos.latitude;
    double lng1 = pos.longitude;

    // จุดที่ 2 (ตัวอย่าง กำหนดเอง)
    double lat2 = 13.7563; // ตัวอย่างพิกัด กทม.
    double lng2 = 100.5018;

    // ใช้ฟังก์ชันนี้คำนวณระยะทาง (หน่วยเป็นเมตร)
    double distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lng1,
      lat2,
      lng2,
    );

    print("ระยะทาง: $distanceInMeters เมตร");
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever)
        return;
    }
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLatLng = LatLng(pos.latitude, pos.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตำแหน่งของฉันบนแผนที่ (OSM)')),
      body:
          _currentLatLng == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                options: MapOptions(
                  initialCenter: _currentLatLng!,
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    // urlTemplate:
                    // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    urlTemplate:
                        'https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}',
                    userAgentPackageName: 'com.example.workshop_map',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: _currentLatLng!,
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
