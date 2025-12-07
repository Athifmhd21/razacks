// main.dart
import 'package:flutter/material.dart';
import 'package:razacks/core/features/mainpage.dart';
import 'package:razacks/core/provider/booking_provider.dart';
import 'package:razacks/core/provider/video_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Mainpage(),
      ),
    );
  }
}
