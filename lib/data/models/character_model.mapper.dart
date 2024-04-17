// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'character_model.dart';

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

  static int _$remoteId(CharacterModel v) => v.remoteId;
  static const Field<CharacterModel, int> _f$remoteId =
      Field('remoteId', _$remoteId, key: 'remote_id');
  static int _$localeId(CharacterModel v) => v.localeId;
  static const Field<CharacterModel, int> _f$localeId =
      Field('localeId', _$localeId, key: 'locale_id');
  static String _$name(CharacterModel v) => v.name;
  static const Field<CharacterModel, String> _f$name = Field('name', _$name);
  static String _$description(CharacterModel v) => v.description;
  static const Field<CharacterModel, String> _f$description =
      Field('description', _$description);
  static String _$image(CharacterModel v) => v.image;
  static const Field<CharacterModel, String> _f$image = Field('image', _$image);

  @override
  final MappableFields<CharacterModel> fields = const {
    #remoteId: _f$remoteId,
    #localeId: _f$localeId,
    #name: _f$name,
    #description: _f$description,
    #image: _f$image,
  };

  static CharacterModel _instantiate(DecodingData data) {
    return CharacterModel(
        remoteId: data.dec(_f$remoteId),
        localeId: data.dec(_f$localeId),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        image: data.dec(_f$image));
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
  $R call(
      {int? remoteId,
      int? localeId,
      String? name,
      String? description,
      String? image});
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
  CharacterModel $make(CopyWithData data) => CharacterModel(
      remoteId: data.get(#remoteId, or: $value.remoteId),
      localeId: data.get(#localeId, or: $value.localeId),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      image: data.get(#image, or: $value.image));

  @override
  CharacterModelCopyWith<$R2, CharacterModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharacterModelCopyWithImpl($value, $cast, t);
}
