import 'package:flutter/material.dart';
import 'package:rm_character_sampler/screens/on_boarding.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RMCharacterSampler',
      home: const OnBoarding(),
    );
  }
}