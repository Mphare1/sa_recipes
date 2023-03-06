import 'dart:async';
import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart';
import 'recipe_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LT Recipe app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        RecipeDetailScreen.routeName: (ctx) => RecipeDetailScreen(),
        RecipeListScreen.routeName: (ctx) => RecipeListScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer = null;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, RecipeListScreen.routeName);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this with your company logo
            Image.asset('assets/lofg.png', width: double.infinity),

            // Replace this with a loading indicator or text
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
