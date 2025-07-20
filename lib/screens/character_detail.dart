import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rm_character_sampler/models/character_model.dart';
import 'package:rm_character_sampler/services/get_character.dart';
import 'package:rm_character_sampler/widgets/detail_row.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  late Future<CharacterModel> _characterFuture;

  @override
  void initState() {
    super.initState();

    int randomCharacterId = Random().nextInt(827);
    _characterFuture = fetchCharacter(id: randomCharacterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CharacterModel>(
        future: _characterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          final character = snapshot.data!;
          final networkImage = NetworkImage(character.image);

          return FutureBuilder<ColorScheme>(
            future: ColorScheme.fromImageProvider(provider: networkImage),
            builder: (ctx, snap) {
              final color = snap.data?.primaryContainer ?? Colors.deepPurple;
              final accent = snap.data?.secondary ?? Colors.deepPurpleAccent;

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, accent.withAlpha(30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.white.withAlpha(220),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  character.image,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                character.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: accent,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Divider(thickness: 2, color: accent),
                              SizedBox(height: 16),
                              DetailRow(
                                icon: Icons.favorite,
                                label: 'Estatus',
                                value: character.status,
                                color: color,
                              ),
                              DetailRow(
                                icon: Icons.person,
                                label: 'Especie',
                                value: character.species,
                                color: color,
                              ),
                              DetailRow(
                                icon: Icons.male,
                                label: 'Genero',
                                value: character.gender,
                                color: color,
                              ),
                              DetailRow(
                                icon: Icons.public,
                                label: 'Origen',
                                value: character.origin,
                                color: color,
                              ),
                              SizedBox(height: 24),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 32,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    int randomCharacterId = Random().nextInt(
                                      827,
                                    );
                                    _characterFuture = fetchCharacter(
                                      id: randomCharacterId,
                                    );
                                  });
                                },
                                icon: Icon(Icons.shuffle),
                                label: Text(
                                  'Random',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
