// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'entities_mapper.dart';

class CharacterEntityMapper extends ClassMapperBase<CharacterEntity> {
  CharacterEntityMapper._();

  static CharacterEntityMapper? _instance;
  static CharacterEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CharacterEntity';

  static String? _$remoteId(CharacterEntity v) => v.remoteId;
  static const Field<CharacterEntity, String> _f$remoteId =
      Field('remoteId', _$remoteId, opt: true);
  static int? _$localeId(CharacterEntity v) => v.localeId;
  static const Field<CharacterEntity, int> _f$localeId =
      Field('localeId', _$localeId, opt: true);
  static String _$name(CharacterEntity v) => v.name;
  static const Field<CharacterEntity, String> _f$name = Field('name', _$name);
  static String _$description(CharacterEntity v) => v.description;
  static const Field<CharacterEntity, String> _f$description =
      Field('description', _$description);
  static String? _$image(CharacterEntity v) => v.image;
  static const Field<CharacterEntity, String> _f$image =
      Field('image', _$image, opt: true);
  static List<int> _$skills(CharacterEntity v) => v.skills;
  static const Field<CharacterEntity, List<int>> _f$skills =
      Field('skills', _$skills);
  static String _$concept(CharacterEntity v) => v.concept;
  static const Field<CharacterEntity, String> _f$concept =
      Field('concept', _$concept);
  static String _$problem(CharacterEntity v) => v.problem;
  static const Field<CharacterEntity, String> _f$problem =
      Field('problem', _$problem);
  static List<String> _$aspects(CharacterEntity v) => v.aspects;
  static const Field<CharacterEntity, List<String>> _f$aspects =
      Field('aspects', _$aspects);
  static List<String> _$stunts(CharacterEntity v) => v.stunts;
  static const Field<CharacterEntity, List<String>> _f$stunts =
      Field('stunts', _$stunts);

  @override
  final MappableFields<CharacterEntity> fields = const {
    #remoteId: _f$remoteId,
    #localeId: _f$localeId,
    #name: _f$name,
    #description: _f$description,
    #image: _f$image,
    #skills: _f$skills,
    #concept: _f$concept,
    #problem: _f$problem,
    #aspects: _f$aspects,
    #stunts: _f$stunts,
  };

  static CharacterEntity _instantiate(DecodingData data) {
    return CharacterEntity(
        remoteId: data.dec(_f$remoteId),
        localeId: data.dec(_f$localeId),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        image: data.dec(_f$image),
        skills: data.dec(_f$skills),
        concept: data.dec(_f$concept),
        problem: data.dec(_f$problem),
        aspects: data.dec(_f$aspects),
        stunts: data.dec(_f$stunts));
  }

  @override
  final Function instantiate = _instantiate;

  static CharacterEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharacterEntity>(map);
  }

  static CharacterEntity fromJson(String json) {
    return ensureInitialized().decodeJson<CharacterEntity>(json);
  }
}

mixin CharacterEntityMappable {
  String toJson() {
    return CharacterEntityMapper.ensureInitialized()
        .encodeJson<CharacterEntity>(this as CharacterEntity);
  }

  Map<String, dynamic> toMap() {
    return CharacterEntityMapper.ensureInitialized()
        .encodeMap<CharacterEntity>(this as CharacterEntity);
  }

  CharacterEntityCopyWith<CharacterEntity, CharacterEntity, CharacterEntity>
      get copyWith => _CharacterEntityCopyWithImpl(
          this as CharacterEntity, $identity, $identity);
  @override
  String toString() {
    return CharacterEntityMapper.ensureInitialized()
        .stringifyValue(this as CharacterEntity);
  }

  @override
  bool operator ==(Object other) {
    return CharacterEntityMapper.ensureInitialized()
        .equalsValue(this as CharacterEntity, other);
  }

  @override
  int get hashCode {
    return CharacterEntityMapper.ensureInitialized()
        .hashValue(this as CharacterEntity);
  }
}

extension CharacterEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharacterEntity, $Out> {
  CharacterEntityCopyWith<$R, CharacterEntity, $Out> get $asCharacterEntity =>
      $base.as((v, t, t2) => _CharacterEntityCopyWithImpl(v, t, t2));
}

abstract class CharacterEntityCopyWith<$R, $In extends CharacterEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get skills;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get stunts;
  $R call(
      {String? remoteId,
      int? localeId,
      String? name,
      String? description,
      String? image,
      List<int>? skills,
      String? concept,
      String? problem,
      List<String>? aspects,
      List<String>? stunts});
  CharacterEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharacterEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharacterEntity, $Out>
    implements CharacterEntityCopyWith<$R, CharacterEntity, $Out> {
  _CharacterEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharacterEntity> $mapper =
      CharacterEntityMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get skills =>
      ListCopyWith($value.skills, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(skills: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects =>
      ListCopyWith($value.aspects, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(aspects: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get stunts =>
      ListCopyWith($value.stunts, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(stunts: v));
  @override
  $R call(
          {Object? remoteId = $none,
          Object? localeId = $none,
          String? name,
          String? description,
          Object? image = $none,
          List<int>? skills,
          String? concept,
          String? problem,
          List<String>? aspects,
          List<String>? stunts}) =>
      $apply(FieldCopyWithData({
        if (remoteId != $none) #remoteId: remoteId,
        if (localeId != $none) #localeId: localeId,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (image != $none) #image: image,
        if (skills != null) #skills: skills,
        if (concept != null) #concept: concept,
        if (problem != null) #problem: problem,
        if (aspects != null) #aspects: aspects,
        if (stunts != null) #stunts: stunts
      }));
  @override
  CharacterEntity $make(CopyWithData data) => CharacterEntity(
      remoteId: data.get(#remoteId, or: $value.remoteId),
      localeId: data.get(#localeId, or: $value.localeId),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      image: data.get(#image, or: $value.image),
      skills: data.get(#skills, or: $value.skills),
      concept: data.get(#concept, or: $value.concept),
      problem: data.get(#problem, or: $value.problem),
      aspects: data.get(#aspects, or: $value.aspects),
      stunts: data.get(#stunts, or: $value.stunts));

  @override
  CharacterEntityCopyWith<$R2, CharacterEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterEntityCopyWithImpl($value, $cast, t);
}
