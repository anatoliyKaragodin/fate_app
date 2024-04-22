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
  static TextEditingController _$nameController(CharacterPageState v) =>
      v.nameController;
  static const Field<CharacterPageState, TextEditingController>
      _f$nameController = Field('nameController', _$nameController);
  static TextEditingController _$descriptionController(CharacterPageState v) =>
      v.descriptionController;
  static const Field<CharacterPageState, TextEditingController>
      _f$descriptionController =
      Field('descriptionController', _$descriptionController);
  static TextEditingController _$conceptController(CharacterPageState v) =>
      v.conceptController;
  static const Field<CharacterPageState, TextEditingController>
      _f$conceptController = Field('conceptController', _$conceptController);
  static TextEditingController _$problemController(CharacterPageState v) =>
      v.problemController;
  static const Field<CharacterPageState, TextEditingController>
      _f$problemController = Field('problemController', _$problemController);
  static List<TextEditingController> _$aspectsControllers(
          CharacterPageState v) =>
      v.aspectsControllers;
  static const Field<CharacterPageState, List<TextEditingController>>
      _f$aspectsControllers = Field('aspectsControllers', _$aspectsControllers);
  static List<int?> _$skills(CharacterPageState v) => v.skills;
  static const Field<CharacterPageState, List<int?>> _f$skills =
      Field('skills', _$skills);
  static List<TextEditingController> _$stuntsControllers(
          CharacterPageState v) =>
      v.stuntsControllers;
  static const Field<CharacterPageState, List<TextEditingController>>
      _f$stuntsControllers = Field('stuntsControllers', _$stuntsControllers);

  @override
  final MappableFields<CharacterPageState> fields = const {
    #character: _f$character,
    #nameController: _f$nameController,
    #descriptionController: _f$descriptionController,
    #conceptController: _f$conceptController,
    #problemController: _f$problemController,
    #aspectsControllers: _f$aspectsControllers,
    #skills: _f$skills,
    #stuntsControllers: _f$stuntsControllers,
  };

  static CharacterPageState _instantiate(DecodingData data) {
    return CharacterPageState(
        character: data.dec(_f$character),
        nameController: data.dec(_f$nameController),
        descriptionController: data.dec(_f$descriptionController),
        conceptController: data.dec(_f$conceptController),
        problemController: data.dec(_f$problemController),
        aspectsControllers: data.dec(_f$aspectsControllers),
        skills: data.dec(_f$skills),
        stuntsControllers: data.dec(_f$stuntsControllers));
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
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get aspectsControllers;
  ListCopyWith<$R, int?, ObjectCopyWith<$R, int?, int?>?> get skills;
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get stuntsControllers;
  $R call(
      {CharacterEntity? character,
      TextEditingController? nameController,
      TextEditingController? descriptionController,
      TextEditingController? conceptController,
      TextEditingController? problemController,
      List<TextEditingController>? aspectsControllers,
      List<int?>? skills,
      List<TextEditingController>? stuntsControllers});
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
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get aspectsControllers => ListCopyWith(
          $value.aspectsControllers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(aspectsControllers: v));
  @override
  ListCopyWith<$R, int?, ObjectCopyWith<$R, int?, int?>?> get skills =>
      ListCopyWith($value.skills, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(skills: v));
  @override
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get stuntsControllers => ListCopyWith(
          $value.stuntsControllers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(stuntsControllers: v));
  @override
  $R call(
          {CharacterEntity? character,
          TextEditingController? nameController,
          TextEditingController? descriptionController,
          TextEditingController? conceptController,
          TextEditingController? problemController,
          List<TextEditingController>? aspectsControllers,
          List<int?>? skills,
          List<TextEditingController>? stuntsControllers}) =>
      $apply(FieldCopyWithData({
        if (character != null) #character: character,
        if (nameController != null) #nameController: nameController,
        if (descriptionController != null)
          #descriptionController: descriptionController,
        if (conceptController != null) #conceptController: conceptController,
        if (problemController != null) #problemController: problemController,
        if (aspectsControllers != null) #aspectsControllers: aspectsControllers,
        if (skills != null) #skills: skills,
        if (stuntsControllers != null) #stuntsControllers: stuntsControllers
      }));
  @override
  CharacterPageState $make(CopyWithData data) => CharacterPageState(
      character: data.get(#character, or: $value.character),
      nameController: data.get(#nameController, or: $value.nameController),
      descriptionController:
          data.get(#descriptionController, or: $value.descriptionController),
      conceptController:
          data.get(#conceptController, or: $value.conceptController),
      problemController:
          data.get(#problemController, or: $value.problemController),
      aspectsControllers:
          data.get(#aspectsControllers, or: $value.aspectsControllers),
      skills: data.get(#skills, or: $value.skills),
      stuntsControllers:
          data.get(#stuntsControllers, or: $value.stuntsControllers));

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
