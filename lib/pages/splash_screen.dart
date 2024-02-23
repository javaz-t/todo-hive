import 'package:blood_donation/pages/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds:  2), // Duration of the animation
      vsync: this,
    );

    _animation = Tween<double>(begin:  0, end:  1).animate(_controller);

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Replace NextScreen with your next screen widget
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(Colors.blue, Colors.purple, _animation.value)!,
                  Color.lerp(Colors.purple, Colors.blue, _animation.value)!,
                ],
              ),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: _animation.value *  30 +  20, // Animate font size from  20 to  50
                  color: Color.lerp(Colors.transparent, Colors.white, _animation.value), // Animate color from transparent to white
                ),
                duration: const Duration(seconds:  2),
                child: const Text(
                  'Taskifly',
                  style: TextStyle(
                    fontSize:  70,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
