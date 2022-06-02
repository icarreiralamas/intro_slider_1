import 'package:flutter/material.dart';
import 'package:intro_slider_1/src/screens/slider_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home':( _ ) => SliderScreen()
      },
    );
  }
}