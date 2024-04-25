part of '../mapper/entities_mapper.dart';

@MappableClass()
class CharacterEntity with CharacterEntityMappable {
  final String? remoteId;
  final int? localeId;
  final String name;
  final String description;
  final String? image;
  final List<int> skills;
  final String concept;
  final String problem;
  final List<String> aspects;
  final List<String> stunts;

  const CharacterEntity(
      {this.remoteId,
      this.localeId,
      required this.name,
      required this.description,
      this.image,
      required this.skills,
      required this.concept,
      required this.problem,
      required this.aspects,
      required this.stunts});
}
