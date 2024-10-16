import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/auth_controller.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Get.put(AuthController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Note'),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                child: LinearProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
