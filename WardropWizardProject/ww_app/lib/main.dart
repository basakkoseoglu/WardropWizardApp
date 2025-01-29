import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ww_app/auth/auth_gate.dart';
import 'package:ww_app/firebase_options.dart';
import 'package:ww_app/services/storage/storage_service.dart';
import 'package:ww_app/themes/light_mode.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ww_app/pages/wardrobe_page.dart'; // WardrobePage için gerekli

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Firebase başarıyla başlatıldı");

  // Hive'i başlat
  await Hive.initFlutter();
  print("Hive başarıyla başlatıldı");

  // Hive için adaptörü kaydet
  Hive.registerAdapter(ImagePredictionAdapter());

  // Hive kutusunu aç
  await Hive.deleteBoxFromDisk('image_predictions');
  await Hive.openBox<ImagePrediction>('image_predictions');
  print("Hive 'image_predictions' kutusu başarıyla açıldı");

  runApp(
    ChangeNotifierProvider(
      create: (context) => StorageService()..initializeHive(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('tr', 'TR'),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}
