// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'models_mapper.dart';

class CharacterModelMapper extends ClassMapperBase<CharacterModel> {
  CharacterModelMapper._();

  static CharacterModelMapper? _instance;
  static CharacterModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CharacterModel';

  static String? _$remoteId(CharacterModel v) => v.remoteId;
  static const Field<CharacterModel, String> _f$remoteId =
      Field('remoteId', _$remoteId, key: 'remote_id', opt: true);
  static int? _$localeId(CharacterModel v) => v.localeId;
  static const Field<CharacterModel, int> _f$localeId =
      Field('localeId', _$localeId, key: 'locale_id', opt: true);
  static String _$name(CharacterModel v) => v.name;
  static const Field<CharacterModel, String> _f$name = Field('name', _$name);
  static String _$description(CharacterModel v) => v.description;
  static const Field<CharacterModel, String> _f$description =
      Field('description', _$description);
  static String? _$image(CharacterModel v) => v.image;
  static const Field<CharacterModel, String> _f$image =
      Field('image', _$image, opt: true);
  static List<int> _$skills(CharacterModel v) => v.skills;
  static const Field<CharacterModel, List<int>> _f$skills =
      Field('skills', _$skills);
  static String _$concept(CharacterModel v) => v.concept;
  static const Field<CharacterModel, String> _f$concept =
      Field('concept', _$concept);
  static String _$problem(CharacterModel v) => v.problem;
  static const Field<CharacterModel, String> _f$problem =
      Field('problem', _$problem);
  static List<String> _$aspects(CharacterModel v) => v.aspects;
  static const Field<CharacterModel, List<String>> _f$aspects =
      Field('aspects', _$aspects);
  static List<String> _$stunts(CharacterModel v) => v.stunts;
  static const Field<CharacterModel, List<String>> _f$stunts =
      Field('stunts', _$stunts);

  @override
  final MappableFields<CharacterModel> fields = const {
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

  static CharacterModel _instantiate(DecodingData data) {
    return CharacterModel(
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

  static CharacterModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharacterModel>(map);
  }

  static CharacterModel fromJson(String json) {
    return ensureInitialized().decodeJson<CharacterModel>(json);
  }
}

mixin CharacterModelMappable {
  String toJson() {
    return CharacterModelMapper.ensureInitialized()
        .encodeJson<CharacterModel>(this as CharacterModel);
  }

  Map<String, dynamic> toMap() {
    return CharacterModelMapper.ensureInitialized()
        .encodeMap<CharacterModel>(this as CharacterModel);
  }

  CharacterModelCopyWith<CharacterModel, CharacterModel, CharacterModel>
      get copyWith => _CharacterModelCopyWithImpl(
          this as CharacterModel, $identity, $identity);
  @override
  String toString() {
    return CharacterModelMapper.ensureInitialized()
        .stringifyValue(this as CharacterModel);
  }

  @override
  bool operator ==(Object other) {
    return CharacterModelMapper.ensureInitialized()
        .equalsValue(this as CharacterModel, other);
  }

  @override
  int get hashCode {
    return CharacterModelMapper.ensureInitialized()
        .hashValue(this as CharacterModel);
  }
}

extension CharacterModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharacterModel, $Out> {
  CharacterModelCopyWith<$R, CharacterModel, $Out> get $asCharacterModel =>
      $base.as((v, t, t2) => _CharacterModelCopyWithImpl(v, t, t2));
}

abstract class CharacterModelCopyWith<$R, $In extends CharacterModel, $Out>
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
  CharacterModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharacterModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharacterModel, $Out>
    implements CharacterModelCopyWith<$R, CharacterModel, $Out> {
  _CharacterModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharacterModel> $mapper =
      CharacterModelMapper.ensureInitialized();
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
  CharacterModel $make(CopyWithData data) => CharacterModel(
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
  CharacterModelCopyWith<$R2, CharacterModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterModelCopyWithImpl($value, $cast, t);
}
