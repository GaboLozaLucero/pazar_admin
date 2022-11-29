import 'package:admin_project_v1/bindings/home_binding.dart';
import 'package:admin_project_v1/navigation/pages.dart';
import 'package:admin_project_v1/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.aclonicaTextTheme(),
      ),
      defaultTransition: Transition.rightToLeft,
      initialBinding: HomeBinding(),
      home: const HomePage(),
      getPages: Pages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
