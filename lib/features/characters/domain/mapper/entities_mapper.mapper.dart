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
      SkillEntityMapper.ensureInitialized();
      StuntEntityMapper.ensureInitialized();
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
  static List<SkillEntity> _$skills(CharacterEntity v) => v.skills;
  static const Field<CharacterEntity, List<SkillEntity>> _f$skills =
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
  static List<StuntEntity> _$stunts(CharacterEntity v) => v.stunts;
  static const Field<CharacterEntity, List<StuntEntity>> _f$stunts =
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
  ListCopyWith<$R, SkillEntity,
      SkillEntityCopyWith<$R, SkillEntity, SkillEntity>> get skills;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects;
  ListCopyWith<$R, StuntEntity,
      StuntEntityCopyWith<$R, StuntEntity, StuntEntity>> get stunts;
  $R call(
      {String? remoteId,
      int? localeId,
      String? name,
      String? description,
      String? image,
      List<SkillEntity>? skills,
      String? concept,
      String? problem,
      List<String>? aspects,
      List<StuntEntity>? stunts});
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
  ListCopyWith<$R, SkillEntity,
          SkillEntityCopyWith<$R, SkillEntity, SkillEntity>>
      get skills => ListCopyWith($value.skills, (v, t) => v.copyWith.$chain(t),
          (v) => call(skills: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get aspects =>
      ListCopyWith($value.aspects, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(aspects: v));
  @override
  ListCopyWith<$R, StuntEntity,
          StuntEntityCopyWith<$R, StuntEntity, StuntEntity>>
      get stunts => ListCopyWith($value.stunts, (v, t) => v.copyWith.$chain(t),
          (v) => call(stunts: v));
  @override
  $R call(
          {Object? remoteId = $none,
          Object? localeId = $none,
          String? name,
          String? description,
          Object? image = $none,
          List<SkillEntity>? skills,
          String? concept,
          String? problem,
          List<String>? aspects,
          List<StuntEntity>? stunts}) =>
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

class SkillEntityMapper extends ClassMapperBase<SkillEntity> {
  SkillEntityMapper._();

  static SkillEntityMapper? _instance;
  static SkillEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SkillEntityMapper._());
      SkillTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SkillEntity';

  static SkillType _$type(SkillEntity v) => v.type;
  static const Field<SkillEntity, SkillType> _f$type = Field('type', _$type);
  static int? _$value(SkillEntity v) => v.value;
  static const Field<SkillEntity, int> _f$value =
      Field('value', _$value, opt: true);

  @override
  final MappableFields<SkillEntity> fields = const {
    #type: _f$type,
    #value: _f$value,
  };

  static SkillEntity _instantiate(DecodingData data) {
    return SkillEntity(type: data.dec(_f$type), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static SkillEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SkillEntity>(map);
  }

  static SkillEntity fromJson(String json) {
    return ensureInitialized().decodeJson<SkillEntity>(json);
  }
}

mixin SkillEntityMappable {
  String toJson() {
    return SkillEntityMapper.ensureInitialized()
        .encodeJson<SkillEntity>(this as SkillEntity);
  }

  Map<String, dynamic> toMap() {
    return SkillEntityMapper.ensureInitialized()
        .encodeMap<SkillEntity>(this as SkillEntity);
  }

  SkillEntityCopyWith<SkillEntity, SkillEntity, SkillEntity> get copyWith =>
      _SkillEntityCopyWithImpl(this as SkillEntity, $identity, $identity);
  @override
  String toString() {
    return SkillEntityMapper.ensureInitialized()
        .stringifyValue(this as SkillEntity);
  }

  @override
  bool operator ==(Object other) {
    return SkillEntityMapper.ensureInitialized()
        .equalsValue(this as SkillEntity, other);
  }

  @override
  int get hashCode {
    return SkillEntityMapper.ensureInitialized().hashValue(this as SkillEntity);
  }
}

extension SkillEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SkillEntity, $Out> {
  SkillEntityCopyWith<$R, SkillEntity, $Out> get $asSkillEntity =>
      $base.as((v, t, t2) => _SkillEntityCopyWithImpl(v, t, t2));
}

abstract class SkillEntityCopyWith<$R, $In extends SkillEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SkillType? type, int? value});
  SkillEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SkillEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SkillEntity, $Out>
    implements SkillEntityCopyWith<$R, SkillEntity, $Out> {
  _SkillEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SkillEntity> $mapper =
      SkillEntityMapper.ensureInitialized();
  @override
  $R call({SkillType? type, Object? value = $none}) => $apply(FieldCopyWithData(
      {if (type != null) #type: type, if (value != $none) #value: value}));
  @override
  SkillEntity $make(CopyWithData data) => SkillEntity(
      type: data.get(#type, or: $value.type),
      value: data.get(#value, or: $value.value));

  @override
  SkillEntityCopyWith<$R2, SkillEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SkillEntityCopyWithImpl($value, $cast, t);
}

class SkillTypeMapper extends EnumMapper<SkillType> {
  SkillTypeMapper._();

  static SkillTypeMapper? _instance;
  static SkillTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SkillTypeMapper._());
    }
    return _instance!;
  }

  static SkillType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SkillType decode(dynamic value) {
    switch (value) {
      case 'careful':
        return SkillType.careful;
      case 'clever':
        return SkillType.clever;
      case 'flashy':
        return SkillType.flashy;
      case 'forceful':
        return SkillType.forceful;
      case 'quick':
        return SkillType.quick;
      case 'sneaky':
        return SkillType.sneaky;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SkillType self) {
    switch (self) {
      case SkillType.careful:
        return 'careful';
      case SkillType.clever:
        return 'clever';
      case SkillType.flashy:
        return 'flashy';
      case SkillType.forceful:
        return 'forceful';
      case SkillType.quick:
        return 'quick';
      case SkillType.sneaky:
        return 'sneaky';
    }
  }
}

extension SkillTypeMapperExtension on SkillType {
  String toValue() {
    SkillTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SkillType>(this) as String;
  }
}

class StuntEntityMapper extends ClassMapperBase<StuntEntity> {
  StuntEntityMapper._();

  static StuntEntityMapper? _instance;
  static StuntEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StuntEntityMapper._());
      StuntTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StuntEntity';

  static StuntType _$type(StuntEntity v) => v.type;
  static const Field<StuntEntity, StuntType> _f$type = Field('type', _$type);
  static String? _$description(StuntEntity v) => v.description;
  static const Field<StuntEntity, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<StuntEntity> fields = const {
    #type: _f$type,
    #description: _f$description,
  };

  static StuntEntity _instantiate(DecodingData data) {
    return StuntEntity(
        type: data.dec(_f$type), description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static StuntEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StuntEntity>(map);
  }

  static StuntEntity fromJson(String json) {
    return ensureInitialized().decodeJson<StuntEntity>(json);
  }
}

mixin StuntEntityMappable {
  String toJson() {
    return StuntEntityMapper.ensureInitialized()
        .encodeJson<StuntEntity>(this as StuntEntity);
  }

  Map<String, dynamic> toMap() {
    return StuntEntityMapper.ensureInitialized()
        .encodeMap<StuntEntity>(this as StuntEntity);
  }

  StuntEntityCopyWith<StuntEntity, StuntEntity, StuntEntity> get copyWith =>
      _StuntEntityCopyWithImpl(this as StuntEntity, $identity, $identity);
  @override
  String toString() {
    return StuntEntityMapper.ensureInitialized()
        .stringifyValue(this as StuntEntity);
  }

  @override
  bool operator ==(Object other) {
    return StuntEntityMapper.ensureInitialized()
        .equalsValue(this as StuntEntity, other);
  }

  @override
  int get hashCode {
    return StuntEntityMapper.ensureInitialized().hashValue(this as StuntEntity);
  }
}

extension StuntEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StuntEntity, $Out> {
  StuntEntityCopyWith<$R, StuntEntity, $Out> get $asStuntEntity =>
      $base.as((v, t, t2) => _StuntEntityCopyWithImpl(v, t, t2));
}

abstract class StuntEntityCopyWith<$R, $In extends StuntEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({StuntType? type, String? description});
  StuntEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StuntEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StuntEntity, $Out>
    implements StuntEntityCopyWith<$R, StuntEntity, $Out> {
  _StuntEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StuntEntity> $mapper =
      StuntEntityMapper.ensureInitialized();
  @override
  $R call({StuntType? type, Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (description != $none) #description: description
      }));
  @override
  StuntEntity $make(CopyWithData data) => StuntEntity(
      type: data.get(#type, or: $value.type),
      description: data.get(#description, or: $value.description));

  @override
  StuntEntityCopyWith<$R2, StuntEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StuntEntityCopyWithImpl($value, $cast, t);
}

class StuntTypeMapper extends EnumMapper<StuntType> {
  StuntTypeMapper._();

  static StuntTypeMapper? _instance;
  static StuntTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StuntTypeMapper._());
    }
    return _instance!;
  }

  static StuntType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StuntType decode(dynamic value) {
    switch (value) {
      case 'one_time':
        return StuntType.oneTime;
      case 'careful':
        return StuntType.careful;
      case 'clever':
        return StuntType.clever;
      case 'flashy':
        return StuntType.flashy;
      case 'forceful':
        return StuntType.forceful;
      case 'quick':
        return StuntType.quick;
      case 'sneaky':
        return StuntType.sneaky;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StuntType self) {
    switch (self) {
      case StuntType.oneTime:
        return 'one_time';
      case StuntType.careful:
        return 'careful';
      case StuntType.clever:
        return 'clever';
      case StuntType.flashy:
        return 'flashy';
      case StuntType.forceful:
        return 'forceful';
      case StuntType.quick:
        return 'quick';
      case StuntType.sneaky:
        return 'sneaky';
    }
  }
}

extension StuntTypeMapperExtension on StuntType {
  String toValue() {
    StuntTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StuntType>(this) as String;
  }
}
