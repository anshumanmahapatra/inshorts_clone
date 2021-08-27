import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/pseudo_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((val) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "FF Clan OT",
      ),
      debugShowCheckedModeBanner: false,
      home: const PseudoHome(),
    );
  }
}
