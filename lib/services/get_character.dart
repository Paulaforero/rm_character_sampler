import 'package:http/http.dart' as http;

Future<http.Response> fetchCharacter({required int id}) {
  return http.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
}