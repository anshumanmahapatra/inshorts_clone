import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Lottie.asset("assets/lottie/loading.json"),
        const SizedBox(height: 40),
        const Text("Loading Shorts...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "FF Clan OT Bold"),),
      ],)
    );
  }
}
