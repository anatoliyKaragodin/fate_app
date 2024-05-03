// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state_mapper.dart';

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

  static CharacterEntity _$character(CharacterPageState v) => v.character;
  static const Field<CharacterPageState, CharacterEntity> _f$character =
      Field('character', _$character);
  static List<int> _$skills(CharacterPageState v) => v.skills;
  static const Field<CharacterPageState, List<int>> _f$skills =
      Field('skills', _$skills);

  @override
  final MappableFields<CharacterPageState> fields = const {
    #character: _f$character,
    #skills: _f$skills,
  };

  static CharacterPageState _instantiate(DecodingData data) {
    return CharacterPageState(
        character: data.dec(_f$character), skills: data.dec(_f$skills));
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
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get skills;
  $R call({CharacterEntity? character, List<int>? skills});
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
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character =>
      $value.character.copyWith.$chain((v) => call(character: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get skills =>
      ListCopyWith($value.skills, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(skills: v));
  @override
  $R call({CharacterEntity? character, List<int>? skills}) =>
      $apply(FieldCopyWithData({
        if (character != null) #character: character,
        if (skills != null) #skills: skills
      }));
  @override
  CharacterPageState $make(CopyWithData data) => CharacterPageState(
      character: data.get(#character, or: $value.character),
      skills: data.get(#skills, or: $value.skills));

  @override
  CharacterPageStateCopyWith<$R2, CharacterPageState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterPageStateCopyWithImpl($value, $cast, t);
}

class CharactersListPageStateMapper
    extends ClassMapperBase<CharactersListPageState> {
  CharactersListPageStateMapper._();

  static CharactersListPageStateMapper? _instance;
  static CharactersListPageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = CharactersListPageStateMapper._());
      CharacterEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CharactersListPageState';

  static List<CharacterEntity> _$characters(CharactersListPageState v) =>
      v.characters;
  static const Field<CharactersListPageState, List<CharacterEntity>>
      _f$characters = Field('characters', _$characters);
  static bool _$isEditing(CharactersListPageState v) => v.isEditing;
  static const Field<CharactersListPageState, bool> _f$isEditing =
      Field('isEditing', _$isEditing);

  @override
  final MappableFields<CharactersListPageState> fields = const {
    #characters: _f$characters,
    #isEditing: _f$isEditing,
  };

  static CharactersListPageState _instantiate(DecodingData data) {
    return CharactersListPageState(
        characters: data.dec(_f$characters), isEditing: data.dec(_f$isEditing));
  }

  @override
  final Function instantiate = _instantiate;

  static CharactersListPageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharactersListPageState>(map);
  }

  static CharactersListPageState fromJson(String json) {
    return ensureInitialized().decodeJson<CharactersListPageState>(json);
  }
}

mixin CharactersListPageStateMappable {
  String toJson() {
    return CharactersListPageStateMapper.ensureInitialized()
        .encodeJson<CharactersListPageState>(this as CharactersListPageState);
  }

  Map<String, dynamic> toMap() {
    return CharactersListPageStateMapper.ensureInitialized()
        .encodeMap<CharactersListPageState>(this as CharactersListPageState);
  }

  CharactersListPageStateCopyWith<CharactersListPageState,
          CharactersListPageState, CharactersListPageState>
      get copyWith => _CharactersListPageStateCopyWithImpl(
          this as CharactersListPageState, $identity, $identity);
  @override
  String toString() {
    return CharactersListPageStateMapper.ensureInitialized()
        .stringifyValue(this as CharactersListPageState);
  }

  @override
  bool operator ==(Object other) {
    return CharactersListPageStateMapper.ensureInitialized()
        .equalsValue(this as CharactersListPageState, other);
  }

  @override
  int get hashCode {
    return CharactersListPageStateMapper.ensureInitialized()
        .hashValue(this as CharactersListPageState);
  }
}

extension CharactersListPageStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharactersListPageState, $Out> {
  CharactersListPageStateCopyWith<$R, CharactersListPageState, $Out>
      get $asCharactersListPageState => $base
          .as((v, t, t2) => _CharactersListPageStateCopyWithImpl(v, t, t2));
}

abstract class CharactersListPageStateCopyWith<
    $R,
    $In extends CharactersListPageState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CharacterEntity,
          CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity>>
      get characters;
  $R call({List<CharacterEntity>? characters, bool? isEditing});
  CharactersListPageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharactersListPageStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharactersListPageState, $Out>
    implements
        CharactersListPageStateCopyWith<$R, CharactersListPageState, $Out> {
  _CharactersListPageStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharactersListPageState> $mapper =
      CharactersListPageStateMapper.ensureInitialized();
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
  CharactersListPageState $make(CopyWithData data) => CharactersListPageState(
      characters: data.get(#characters, or: $value.characters),
      isEditing: data.get(#isEditing, or: $value.isEditing));

  @override
  CharactersListPageStateCopyWith<$R2, CharactersListPageState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CharactersListPageStateCopyWithImpl($value, $cast, t);
}
