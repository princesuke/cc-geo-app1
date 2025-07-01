import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Geolocator Workshop')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.gps),
          child: const Text('ทดสอบรับตำแหน่ง GPS'),
        ),
      ),
    );
  }
}
