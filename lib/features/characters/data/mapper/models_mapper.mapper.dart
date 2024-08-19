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
      SkillModelMapper.ensureInitialized();
      StuntModelMapper.ensureInitialized();
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
  static List<SkillModel> _$skills(CharacterModel v) => v.skills;
  static const Field<CharacterModel, List<SkillModel>> _f$skills =
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
  static List<StuntModel> _$stunts(CharacterModel v) => v.stunts;
  static const Field<CharacterModel, List<StuntModel>> _f$stunts =
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
  ListCopyWith<$R, SkillModel, SkillModelCopyWith<$R, SkillModel, SkillModel>>
      get skills;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects;
  ListCopyWith<$R, StuntModel, StuntModelCopyWith<$R, StuntModel, StuntModel>>
      get stunts;
  $R call(
      {String? remoteId,
      int? localeId,
      String? name,
      String? description,
      String? image,
      List<SkillModel>? skills,
      String? concept,
      String? problem,
      List<String>? aspects,
      List<StuntModel>? stunts});
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
  ListCopyWith<$R, SkillModel, SkillModelCopyWith<$R, SkillModel, SkillModel>>
      get skills => ListCopyWith($value.skills, (v, t) => v.copyWith.$chain(t),
          (v) => call(skills: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects =>
      ListCopyWith($value.aspects, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(aspects: v));
  @override
  ListCopyWith<$R, StuntModel, StuntModelCopyWith<$R, StuntModel, StuntModel>>
      get stunts => ListCopyWith($value.stunts, (v, t) => v.copyWith.$chain(t),
          (v) => call(stunts: v));
  @override
  $R call(
          {Object? remoteId = $none,
          Object? localeId = $none,
          String? name,
          String? description,
          Object? image = $none,
          List<SkillModel>? skills,
          String? concept,
          String? problem,
          List<String>? aspects,
          List<StuntModel>? stunts}) =>
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

class SkillModelMapper extends ClassMapperBase<SkillModel> {
  SkillModelMapper._();

  static SkillModelMapper? _instance;
  static SkillModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SkillModelMapper._());
      SkillEntityMapper.ensureInitialized();
      SkillTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SkillModel';

  static SkillType _$type(SkillModel v) => v.type;
  static const Field<SkillModel, SkillType> _f$type = Field('type', _$type);
  static int? _$value(SkillModel v) => v.value;
  static const Field<SkillModel, int> _f$value =
      Field('value', _$value, opt: true);

  @override
  final MappableFields<SkillModel> fields = const {
    #type: _f$type,
    #value: _f$value,
  };

  static SkillModel _instantiate(DecodingData data) {
    return SkillModel(type: data.dec(_f$type), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static SkillModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SkillModel>(map);
  }

  static SkillModel fromJson(String json) {
    return ensureInitialized().decodeJson<SkillModel>(json);
  }
}

mixin SkillModelMappable {
  String toJson() {
    return SkillModelMapper.ensureInitialized()
        .encodeJson<SkillModel>(this as SkillModel);
  }

  Map<String, dynamic> toMap() {
    return SkillModelMapper.ensureInitialized()
        .encodeMap<SkillModel>(this as SkillModel);
  }

  SkillModelCopyWith<SkillModel, SkillModel, SkillModel> get copyWith =>
      _SkillModelCopyWithImpl(this as SkillModel, $identity, $identity);
  @override
  String toString() {
    return SkillModelMapper.ensureInitialized()
        .stringifyValue(this as SkillModel);
  }

  @override
  bool operator ==(Object other) {
    return SkillModelMapper.ensureInitialized()
        .equalsValue(this as SkillModel, other);
  }

  @override
  int get hashCode {
    return SkillModelMapper.ensureInitialized().hashValue(this as SkillModel);
  }
}

extension SkillModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SkillModel, $Out> {
  SkillModelCopyWith<$R, SkillModel, $Out> get $asSkillModel =>
      $base.as((v, t, t2) => _SkillModelCopyWithImpl(v, t, t2));
}

abstract class SkillModelCopyWith<$R, $In extends SkillModel, $Out>
    implements SkillEntityCopyWith<$R, $In, $Out> {
  @override
  $R call({SkillType? type, int? value});
  SkillModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SkillModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SkillModel, $Out>
    implements SkillModelCopyWith<$R, SkillModel, $Out> {
  _SkillModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SkillModel> $mapper =
      SkillModelMapper.ensureInitialized();
  @override
  $R call({SkillType? type, Object? value = $none}) => $apply(FieldCopyWithData(
      {if (type != null) #type: type, if (value != $none) #value: value}));
  @override
  SkillModel $make(CopyWithData data) => SkillModel(
      type: data.get(#type, or: $value.type),
      value: data.get(#value, or: $value.value));

  @override
  SkillModelCopyWith<$R2, SkillModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SkillModelCopyWithImpl($value, $cast, t);
}

class StuntModelMapper extends ClassMapperBase<StuntModel> {
  StuntModelMapper._();

  static StuntModelMapper? _instance;
  static StuntModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StuntModelMapper._());
      StuntEntityMapper.ensureInitialized();
      StuntTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StuntModel';

  static StuntType _$type(StuntModel v) => v.type;
  static const Field<StuntModel, StuntType> _f$type = Field('type', _$type);
  static String? _$description(StuntModel v) => v.description;
  static const Field<StuntModel, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<StuntModel> fields = const {
    #type: _f$type,
    #description: _f$description,
  };

  static StuntModel _instantiate(DecodingData data) {
    return StuntModel(
        type: data.dec(_f$type), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static StuntModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StuntModel>(map);
  }

  static StuntModel fromJson(String json) {
    return ensureInitialized().decodeJson<StuntModel>(json);
  }
}

mixin StuntModelMappable {
  String toJson() {
    return StuntModelMapper.ensureInitialized()
        .encodeJson<StuntModel>(this as StuntModel);
  }

  Map<String, dynamic> toMap() {
    return StuntModelMapper.ensureInitialized()
        .encodeMap<StuntModel>(this as StuntModel);
  }

  StuntModelCopyWith<StuntModel, StuntModel, StuntModel> get copyWith =>
      _StuntModelCopyWithImpl(this as StuntModel, $identity, $identity);
  @override
  String toString() {
    return StuntModelMapper.ensureInitialized()
        .stringifyValue(this as StuntModel);
  }

  @override
  bool operator ==(Object other) {
    return StuntModelMapper.ensureInitialized()
        .equalsValue(this as StuntModel, other);
  }

  @override
  int get hashCode {
    return StuntModelMapper.ensureInitialized().hashValue(this as StuntModel);
  }
}

extension StuntModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StuntModel, $Out> {
  StuntModelCopyWith<$R, StuntModel, $Out> get $asStuntModel =>
      $base.as((v, t, t2) => _StuntModelCopyWithImpl(v, t, t2));
}

abstract class StuntModelCopyWith<$R, $In extends StuntModel, $Out>
    implements StuntEntityCopyWith<$R, $In, $Out> {
  @override
  $R call({StuntType? type, String? description});
  StuntModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StuntModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StuntModel, $Out>
    implements StuntModelCopyWith<$R, StuntModel, $Out> {
  _StuntModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StuntModel> $mapper =
      StuntModelMapper.ensureInitialized();
  @override
  $R call({StuntType? type, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (description != $none) #description: description
      }));
  @override
  StuntModel $make(CopyWithData data) => StuntModel(
      type: data.get(#type, or: $value.type),
      description: data.get(#description, or: $value.description));

  @override
  StuntModelCopyWith<$R2, StuntModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StuntModelCopyWithImpl($value, $cast, t);
}
