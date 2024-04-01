import 'package:flutter/material.dart';
import 'Log_Sign/LogSign.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key); // Corrected constructor declaration

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<splash_screen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // After the animation is complete, navigate to the home screen
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LogSign()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF006400), // Parrot green color
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset('assets/Logo.png',
              width: 400,
              height: 400,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}