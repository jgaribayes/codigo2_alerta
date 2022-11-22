import 'package:codigo2_alerta/ui/pages/home_page.dart';
import 'package:codigo2_alerta/ui/pages/login_page.dart';
import 'package:codigo2_alerta/utilis/sp_global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal _prefs = SPGlobal();
  await _prefs.initSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alerta App",
      theme: ThemeData(
        textTheme: GoogleFonts.workSansTextTheme(),
      ),
      home: PreInit(),
    );
  }
}


class PreInit extends StatelessWidget {
  final SPGlobal _prefs = SPGlobal();
  @override
  Widget build(BuildContext context) {
    return _prefs.token.isEmpty ? LoginPage() : HomePage();
  }
}

