import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/src/db/firestore_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:lsp_pt_barokah/src/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        StreamProvider.value(
            value: firestoreService.getAllLaporan(), initialData: null),
        StreamProvider.value(
            value: firestoreService.getAllKaryawan(), initialData: null)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const HomePage(),
      ),
    );
  }
}
