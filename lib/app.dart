import 'package:flutter/material.dart';
import 'package:rm_character_sampler/screens/on_boarding.dart';
import 'package:rm_character_sampler/screens/character_detail.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RMCharacterSampler',
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding(),
        '/random-character': (context) => const CharacterDetail(),
      },
    );
  }
}