import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
      future:
          Future.delayed(const Duration(seconds: 3), () => "Intro Completed."),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: Text("Splash"));
      },
    )));
  }

  void navigate() {
    FutureBuilder(
      future:
          Future.delayed(const Duration(seconds: 3), () => "Intro Completed."),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: Text("Splash"));
      },
    );
  }
}
