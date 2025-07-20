import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rm_character_sampler/models/character_model.dart';

Future<CharacterModel> fetchCharacter({required int id}) async {
  final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));

  if (response.statusCode == 200) {
    return CharacterModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load character');
  }
}