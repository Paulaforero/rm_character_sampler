class CharacterModel {
final String id;
final String name;
final String status;
final String species;
final String gender;
final String image;
final String origin;

CharacterModel({
  required this.id,
  required this.name,
  required this.status,
  required this.species,
  required this.gender,
  required this.image,
  required this.origin,

});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'].toString(),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
      origin: json['origin']['name'],
    );
  }
}