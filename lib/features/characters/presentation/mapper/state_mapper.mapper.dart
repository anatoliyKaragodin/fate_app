// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state_mapper.dart';

class CharacterEditPageStateMapper
    extends ClassMapperBase<CharacterEditPageState> {
  CharacterEditPageStateMapper._();

  static CharacterEditPageStateMapper? _instance;
  static CharacterEditPageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterEditPageStateMapper._());
      CharacterEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CharacterEditPageState';

  static CharacterEntity _$character(CharacterEditPageState v) => v.character;
  static const Field<CharacterEditPageState, CharacterEntity> _f$character =
      Field('character', _$character);
  static List<int?> _$skillAvailableList(CharacterEditPageState v) =>
      v.skillAvailableList;
  static const Field<CharacterEditPageState, List<int?>> _f$skillAvailableList =
      Field('skillAvailableList', _$skillAvailableList);
  static List<TextEditingController> _$aspectControllers(
          CharacterEditPageState v) =>
      v.aspectControllers;
  static const Field<CharacterEditPageState, List<TextEditingController>>
      _f$aspectControllers = Field('aspectControllers', _$aspectControllers);
  static TextEditingController _$conceptController(CharacterEditPageState v) =>
      v.conceptController;
  static const Field<CharacterEditPageState, TextEditingController>
      _f$conceptController = Field('conceptController', _$conceptController);
  static TextEditingController _$descriptionController(
          CharacterEditPageState v) =>
      v.descriptionController;
  static const Field<CharacterEditPageState, TextEditingController>
      _f$descriptionController =
      Field('descriptionController', _$descriptionController);
  static TextEditingController _$nameController(CharacterEditPageState v) =>
      v.nameController;
  static const Field<CharacterEditPageState, TextEditingController>
      _f$nameController = Field('nameController', _$nameController);
  static TextEditingController _$problemController(CharacterEditPageState v) =>
      v.problemController;
  static const Field<CharacterEditPageState, TextEditingController>
      _f$problemController = Field('problemController', _$problemController);
  static List<TextEditingController> _$stuntControllers(
          CharacterEditPageState v) =>
      v.stuntControllers;
  static const Field<CharacterEditPageState, List<TextEditingController>>
      _f$stuntControllers = Field('stuntControllers', _$stuntControllers);

  @override
  final MappableFields<CharacterEditPageState> fields = const {
    #character: _f$character,
    #skillAvailableList: _f$skillAvailableList,
    #aspectControllers: _f$aspectControllers,
    #conceptController: _f$conceptController,
    #descriptionController: _f$descriptionController,
    #nameController: _f$nameController,
    #problemController: _f$problemController,
    #stuntControllers: _f$stuntControllers,
  };

  static CharacterEditPageState _instantiate(DecodingData data) {
    return CharacterEditPageState(
        character: data.dec(_f$character),
        skillAvailableList: data.dec(_f$skillAvailableList),
        aspectControllers: data.dec(_f$aspectControllers),
        conceptController: data.dec(_f$conceptController),
        descriptionController: data.dec(_f$descriptionController),
        nameController: data.dec(_f$nameController),
        problemController: data.dec(_f$problemController),
        stuntControllers: data.dec(_f$stuntControllers));
  }

  @override
  final Function instantiate = _instantiate;

  static CharacterEditPageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharacterEditPageState>(map);
  }

  static CharacterEditPageState fromJson(String json) {
    return ensureInitialized().decodeJson<CharacterEditPageState>(json);
  }
}

mixin CharacterEditPageStateMappable {
  String toJson() {
    return CharacterEditPageStateMapper.ensureInitialized()
        .encodeJson<CharacterEditPageState>(this as CharacterEditPageState);
  }

  Map<String, dynamic> toMap() {
    return CharacterEditPageStateMapper.ensureInitialized()
        .encodeMap<CharacterEditPageState>(this as CharacterEditPageState);
  }

  CharacterEditPageStateCopyWith<CharacterEditPageState, CharacterEditPageState,
          CharacterEditPageState>
      get copyWith => _CharacterEditPageStateCopyWithImpl(
          this as CharacterEditPageState, $identity, $identity);
  @override
  String toString() {
    return CharacterEditPageStateMapper.ensureInitialized()
        .stringifyValue(this as CharacterEditPageState);
  }

  @override
  bool operator ==(Object other) {
    return CharacterEditPageStateMapper.ensureInitialized()
        .equalsValue(this as CharacterEditPageState, other);
  }

  @override
  int get hashCode {
    return CharacterEditPageStateMapper.ensureInitialized()
        .hashValue(this as CharacterEditPageState);
  }
}

extension CharacterEditPageStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharacterEditPageState, $Out> {
  CharacterEditPageStateCopyWith<$R, CharacterEditPageState, $Out>
      get $asCharacterEditPageState =>
          $base.as((v, t, t2) => _CharacterEditPageStateCopyWithImpl(v, t, t2));
}

abstract class CharacterEditPageStateCopyWith<
    $R,
    $In extends CharacterEditPageState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character;
  ListCopyWith<$R, int?, ObjectCopyWith<$R, int?, int?>?>
      get skillAvailableList;
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get aspectControllers;
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get stuntControllers;
  $R call(
      {CharacterEntity? character,
      List<int?>? skillAvailableList,
      List<TextEditingController>? aspectControllers,
      TextEditingController? conceptController,
      TextEditingController? descriptionController,
      TextEditingController? nameController,
      TextEditingController? problemController,
      List<TextEditingController>? stuntControllers});
  CharacterEditPageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharacterEditPageStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharacterEditPageState, $Out>
    implements
        CharacterEditPageStateCopyWith<$R, CharacterEditPageState, $Out> {
  _CharacterEditPageStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharacterEditPageState> $mapper =
      CharacterEditPageStateMapper.ensureInitialized();
  @override
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character =>
      $value.character.copyWith.$chain((v) => call(character: v));
  @override
  ListCopyWith<$R, int?, ObjectCopyWith<$R, int?, int?>?>
      get skillAvailableList => ListCopyWith(
          $value.skillAvailableList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(skillAvailableList: v));
  @override
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get aspectControllers => ListCopyWith(
          $value.aspectControllers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(aspectControllers: v));
  @override
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get stuntControllers => ListCopyWith(
          $value.stuntControllers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(stuntControllers: v));
  @override
  $R call(
          {CharacterEntity? character,
          List<int?>? skillAvailableList,
          List<TextEditingController>? aspectControllers,
          TextEditingController? conceptController,
          TextEditingController? descriptionController,
          TextEditingController? nameController,
          TextEditingController? problemController,
          List<TextEditingController>? stuntControllers}) =>
      $apply(FieldCopyWithData({
        if (character != null) #character: character,
        if (skillAvailableList != null) #skillAvailableList: skillAvailableList,
        if (aspectControllers != null) #aspectControllers: aspectControllers,
        if (conceptController != null) #conceptController: conceptController,
        if (descriptionController != null)
          #descriptionController: descriptionController,
        if (nameController != null) #nameController: nameController,
        if (problemController != null) #problemController: problemController,
        if (stuntControllers != null) #stuntControllers: stuntControllers
      }));
  @override
  CharacterEditPageState $make(CopyWithData data) => CharacterEditPageState(
      character: data.get(#character, or: $value.character),
      skillAvailableList:
          data.get(#skillAvailableList, or: $value.skillAvailableList),
      aspectControllers:
          data.get(#aspectControllers, or: $value.aspectControllers),
      conceptController:
          data.get(#conceptController, or: $value.conceptController),
      descriptionController:
          data.get(#descriptionController, or: $value.descriptionController),
      nameController: data.get(#nameController, or: $value.nameController),
      problemController:
          data.get(#problemController, or: $value.problemController),
      stuntControllers:
          data.get(#stuntControllers, or: $value.stuntControllers));

  @override
  CharacterEditPageStateCopyWith<$R2, CharacterEditPageState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CharacterEditPageStateCopyWithImpl($value, $cast, t);
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
  static SortType _$sortType(CharactersListPageState v) => v.sortType;
  static const Field<CharactersListPageState, SortType> _f$sortType =
      Field('sortType', _$sortType);

  @override
  final MappableFields<CharactersListPageState> fields = const {
    #characters: _f$characters,
    #isEditing: _f$isEditing,
    #sortType: _f$sortType,
  };

  static CharactersListPageState _instantiate(DecodingData data) {
    return CharactersListPageState(
        characters: data.dec(_f$characters),
        isEditing: data.dec(_f$isEditing),
        sortType: data.dec(_f$sortType));
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
  $R call(
      {List<CharacterEntity>? characters, bool? isEditing, SortType? sortType});
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
  $R call(
          {List<CharacterEntity>? characters,
          bool? isEditing,
          SortType? sortType}) =>
      $apply(FieldCopyWithData({
        if (characters != null) #characters: characters,
        if (isEditing != null) #isEditing: isEditing,
        if (sortType != null) #sortType: sortType
      }));
  @override
  CharactersListPageState $make(CopyWithData data) => CharactersListPageState(
      characters: data.get(#characters, or: $value.characters),
      isEditing: data.get(#isEditing, or: $value.isEditing),
      sortType: data.get(#sortType, or: $value.sortType));

  @override
  CharactersListPageStateCopyWith<$R2, CharactersListPageState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CharactersListPageStateCopyWithImpl($value, $cast, t);
}

class CharacterPlayPageStateMapper
    extends ClassMapperBase<CharacterPlayPageState> {
  CharacterPlayPageStateMapper._();

  static CharacterPlayPageStateMapper? _instance;
  static CharacterPlayPageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharacterPlayPageStateMapper._());
      CharacterEntityMapper.ensureInitialized();
      RollResultEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CharacterPlayPageState';

  static CharacterEntity _$character(CharacterPlayPageState v) => v.character;
  static const Field<CharacterPlayPageState, CharacterEntity> _f$character =
      Field('character', _$character);
  static bool _$isCompact(CharacterPlayPageState v) => v.isCompact;
  static const Field<CharacterPlayPageState, bool> _f$isCompact =
      Field('isCompact', _$isCompact);
  static bool _$isScreenLocked(CharacterPlayPageState v) => v.isScreenLocked;
  static const Field<CharacterPlayPageState, bool> _f$isScreenLocked =
      Field('isScreenLocked', _$isScreenLocked);
  static List<TextEditingController> _$consequencesControllers(
          CharacterPlayPageState v) =>
      v.consequencesControllers;
  static const Field<CharacterPlayPageState, List<TextEditingController>>
      _f$consequencesControllers =
      Field('consequencesControllers', _$consequencesControllers);
  static bool _$isDiceRollShown(CharacterPlayPageState v) => v.isDiceRollShown;
  static const Field<CharacterPlayPageState, bool> _f$isDiceRollShown =
      Field('isDiceRollShown', _$isDiceRollShown);
  static List<RollResultEntity> _$rollResults(CharacterPlayPageState v) =>
      v.rollResults;
  static const Field<CharacterPlayPageState, List<RollResultEntity>>
      _f$rollResults = Field('rollResults', _$rollResults);

  @override
  final MappableFields<CharacterPlayPageState> fields = const {
    #character: _f$character,
    #isCompact: _f$isCompact,
    #isScreenLocked: _f$isScreenLocked,
    #consequencesControllers: _f$consequencesControllers,
    #isDiceRollShown: _f$isDiceRollShown,
    #rollResults: _f$rollResults,
  };

  static CharacterPlayPageState _instantiate(DecodingData data) {
    return CharacterPlayPageState(
        character: data.dec(_f$character),
        isCompact: data.dec(_f$isCompact),
        isScreenLocked: data.dec(_f$isScreenLocked),
        consequencesControllers: data.dec(_f$consequencesControllers),
        isDiceRollShown: data.dec(_f$isDiceRollShown),
        rollResults: data.dec(_f$rollResults));
  }

  @override
  final Function instantiate = _instantiate;

  static CharacterPlayPageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharacterPlayPageState>(map);
  }

  static CharacterPlayPageState fromJson(String json) {
    return ensureInitialized().decodeJson<CharacterPlayPageState>(json);
  }
}

mixin CharacterPlayPageStateMappable {
  String toJson() {
    return CharacterPlayPageStateMapper.ensureInitialized()
        .encodeJson<CharacterPlayPageState>(this as CharacterPlayPageState);
  }

  Map<String, dynamic> toMap() {
    return CharacterPlayPageStateMapper.ensureInitialized()
        .encodeMap<CharacterPlayPageState>(this as CharacterPlayPageState);
  }

  CharacterPlayPageStateCopyWith<CharacterPlayPageState, CharacterPlayPageState,
          CharacterPlayPageState>
      get copyWith => _CharacterPlayPageStateCopyWithImpl(
          this as CharacterPlayPageState, $identity, $identity);
  @override
  String toString() {
    return CharacterPlayPageStateMapper.ensureInitialized()
        .stringifyValue(this as CharacterPlayPageState);
  }

  @override
  bool operator ==(Object other) {
    return CharacterPlayPageStateMapper.ensureInitialized()
        .equalsValue(this as CharacterPlayPageState, other);
  }

  @override
  int get hashCode {
    return CharacterPlayPageStateMapper.ensureInitialized()
        .hashValue(this as CharacterPlayPageState);
  }
}

extension CharacterPlayPageStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharacterPlayPageState, $Out> {
  CharacterPlayPageStateCopyWith<$R, CharacterPlayPageState, $Out>
      get $asCharacterPlayPageState =>
          $base.as((v, t, t2) => _CharacterPlayPageStateCopyWithImpl(v, t, t2));
}

abstract class CharacterPlayPageStateCopyWith<
    $R,
    $In extends CharacterPlayPageState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character;
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get consequencesControllers;
  ListCopyWith<$R, RollResultEntity,
          RollResultEntityCopyWith<$R, RollResultEntity, RollResultEntity>>
      get rollResults;
  $R call(
      {CharacterEntity? character,
      bool? isCompact,
      bool? isScreenLocked,
      List<TextEditingController>? consequencesControllers,
      bool? isDiceRollShown,
      List<RollResultEntity>? rollResults});
  CharacterPlayPageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CharacterPlayPageStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharacterPlayPageState, $Out>
    implements
        CharacterPlayPageStateCopyWith<$R, CharacterPlayPageState, $Out> {
  _CharacterPlayPageStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharacterPlayPageState> $mapper =
      CharacterPlayPageStateMapper.ensureInitialized();
  @override
  CharacterEntityCopyWith<$R, CharacterEntity, CharacterEntity> get character =>
      $value.character.copyWith.$chain((v) => call(character: v));
  @override
  ListCopyWith<$R, TextEditingController,
          ObjectCopyWith<$R, TextEditingController, TextEditingController>>
      get consequencesControllers => ListCopyWith(
          $value.consequencesControllers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(consequencesControllers: v));
  @override
  ListCopyWith<$R, RollResultEntity,
          RollResultEntityCopyWith<$R, RollResultEntity, RollResultEntity>>
      get rollResults => ListCopyWith($value.rollResults,
          (v, t) => v.copyWith.$chain(t), (v) => call(rollResults: v));
  @override
  $R call(
          {CharacterEntity? character,
          bool? isCompact,
          bool? isScreenLocked,
          List<TextEditingController>? consequencesControllers,
          bool? isDiceRollShown,
          List<RollResultEntity>? rollResults}) =>
      $apply(FieldCopyWithData({
        if (character != null) #character: character,
        if (isCompact != null) #isCompact: isCompact,
        if (isScreenLocked != null) #isScreenLocked: isScreenLocked,
        if (consequencesControllers != null)
          #consequencesControllers: consequencesControllers,
        if (isDiceRollShown != null) #isDiceRollShown: isDiceRollShown,
        if (rollResults != null) #rollResults: rollResults
      }));
  @override
  CharacterPlayPageState $make(CopyWithData data) => CharacterPlayPageState(
      character: data.get(#character, or: $value.character),
      isCompact: data.get(#isCompact, or: $value.isCompact),
      isScreenLocked: data.get(#isScreenLocked, or: $value.isScreenLocked),
      consequencesControllers: data.get(#consequencesControllers,
          or: $value.consequencesControllers),
      isDiceRollShown: data.get(#isDiceRollShown, or: $value.isDiceRollShown),
      rollResults: data.get(#rollResults, or: $value.rollResults));

  @override
  CharacterPlayPageStateCopyWith<$R2, CharacterPlayPageState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CharacterPlayPageStateCopyWithImpl($value, $cast, t);
}
