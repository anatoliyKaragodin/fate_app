// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'models_mapper.dart';

class CharacterPageStateMapper extends ClassMapperBase<CharacterPageState> {
  CharacterPageStateMapper._();

  static CharacterPageStateMapper? _instance;
  static CharacterPageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterPageStateMapper._());
      CharacterEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CharacterPageState';

  static List<CharacterEntity> _$characters(CharacterPageState v) =>
      v.characters;
  static const Field<CharacterPageState, List<CharacterEntity>> _f$characters =
      Field('characters', _$characters);
  static bool _$isEditing(CharacterPageState v) => v.isEditing;
  static const Field<CharacterPageState, bool> _f$isEditing =
      Field('isEditing', _$isEditing);

  @override
  final MappableFields<CharacterPageState> fields = const {
    #characters: _f$characters,
    #isEditing: _f$isEditing,
  };

  static CharacterPageState _instantiate(DecodingData data) {
    return CharacterPageState(
        characters: data.dec(_f$characters), isEditing: data.dec(_f$isEditing));
  }

  @override
  final Function instantiate = _instantiate;

  static CharacterPageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharacterPageState>(map);
  }

  static CharacterPageState fromJson(String json) {
    return ensureInitialized().decodeJson<CharacterPageState>(json);
  }
}

mixin CharacterPageStateMappable {
  String toJson() {
    return CharacterPageStateMapper.ensureInitialized()
        .encodeJson<CharacterPageState>(this as CharacterPageState);
  }

  Map<String, dynamic> toMap() {
    return CharacterPageStateMapper.ensureInitialized()
        .encodeMap<CharacterPageState>(this as CharacterPageState);
  }

  CharacterPageStateCopyWith<CharacterPageState, CharacterPageState,
          CharacterPageState>
      get copyWith => _CharacterPageStateCopyWithImpl(
          this as CharacterPageState, $identity, $identity);
  @override
  String toString() {
    return CharacterPageStateMapper.ensureInitialized()
        .stringifyValue(this as CharacterPageState);
  }

  @override
  bool operator ==(Object other) {
    return CharacterPageStateMapper.ensureInitialized()
        .equalsValue(this as CharacterPageState, other);
  }

  @override
  int get hashCode {
    return CharacterPageStateMapper.ensureInitialized()
        .hashValue(this as CharacterPageState);
  }
}

extension CharacterPageStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharacterPageState, $Out> {
  CharacterPageStateCopyWith<$R, CharacterPageState, $Out>
      get $asCharacterPageState =>
          $base.as((v, t, t2) => _CharacterPageStateCopyWithImpl(v, t, t2));
}

abstract class CharacterPageStateCopyWith<$R, $In extends CharacterPageState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CharacterEntity,
          CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity>>
      get characters;
  $R call({List<CharacterEntity>? characters, bool? isEditing});
  CharacterPageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharacterPageStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharacterPageState, $Out>
    implements CharacterPageStateCopyWith<$R, CharacterPageState, $Out> {
  _CharacterPageStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharacterPageState> $mapper =
      CharacterPageStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CharacterEntity,
          CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity>>
      get characters => ListCopyWith($value.characters,
          (v, t) => v.copyWith.$chain(t), (v) => call(characters: v));
  @override
  $R call({List<CharacterEntity>? characters, bool? isEditing}) =>
      $apply(FieldCopyWithData({
        if (characters != null) #characters: characters,
        if (isEditing != null) #isEditing: isEditing
      }));
  @override
  CharacterPageState $make(CopyWithData data) => CharacterPageState(
      characters: data.get(#characters, or: $value.characters),
      isEditing: data.get(#isEditing, or: $value.isEditing));

  @override
  CharacterPageStateCopyWith<$R2, CharacterPageState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterPageStateCopyWithImpl($value, $cast, t);
}

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

  static int _$remoteId(CharacterEntity v) => v.remoteId;
  static const Field<CharacterEntity, int> _f$remoteId =
      Field('remoteId', _$remoteId);
  static int _$localeId(CharacterEntity v) => v.localeId;
  static const Field<CharacterEntity, int> _f$localeId =
      Field('localeId', _$localeId);
  static String _$name(CharacterEntity v) => v.name;
  static const Field<CharacterEntity, String> _f$name = Field('name', _$name);
  static String _$description(CharacterEntity v) => v.description;
  static const Field<CharacterEntity, String> _f$description =
      Field('description', _$description);
  static String _$image(CharacterEntity v) => v.image;
  static const Field<CharacterEntity, String> _f$image =
      Field('image', _$image);

  @override
  final MappableFields<CharacterEntity> fields = const {
    #remoteId: _f$remoteId,
    #localeId: _f$localeId,
    #name: _f$name,
    #description: _f$description,
    #image: _f$image,
  };

  static CharacterEntity _instantiate(DecodingData data) {
    return CharacterEntity(
        remoteId: data.dec(_f$remoteId),
        localeId: data.dec(_f$localeId),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        image: data.dec(_f$image));
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
  $R call(
      {int? remoteId,
      int? localeId,
      String? name,
      String? description,
      String? image});
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
  $R call(
          {int? remoteId,
          int? localeId,
          String? name,
          String? description,
          String? image}) =>
      $apply(FieldCopyWithData({
        if (remoteId != null) #remoteId: remoteId,
        if (localeId != null) #localeId: localeId,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (image != null) #image: image
      }));
  @override
  CharacterEntity $make(CopyWithData data) => CharacterEntity(
      remoteId: data.get(#remoteId, or: $value.remoteId),
      localeId: data.get(#localeId, or: $value.localeId),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      image: data.get(#image, or: $value.image));

  @override
  CharacterEntityCopyWith<$R2, CharacterEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterEntityCopyWithImpl($value, $cast, t);
}
