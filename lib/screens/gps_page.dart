import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsPage extends StatefulWidget {
  const GpsPage({super.key});

  @override
  State<GpsPage> createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  String location = 'ยังไม่ได้รับข้อมูล';

  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => location = 'กรุณาเปิด GPS');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ทดสอบ GPS')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(location),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getLocation,
              child: const Text('รับตำแหน่งปัจจุบัน'),
            ),
          ],
        ),
      ),
    );
  }
}
