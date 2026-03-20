import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

class CharacterAiDraftParser {
  static const _pyramidMultiset = [0, 1, 1, 2, 2, 3];

  static Either<Failure, CharacterAiDraft> parseModelContent(String raw) {
    final jsonText = _stripCodeFence(raw.trim());
    Map<String, dynamic> map;
    try {
      final decoded = jsonDecode(jsonText);
      if (decoded is! Map) {
        return const Left(UnknownFailure(message: 'Ответ ИИ не является JSON-объектом.'));
      }
      map = Map<String, dynamic>.from(decoded);
    } on FormatException catch (e) {
      return Left(UnknownFailure(message: 'Некорректный JSON от ИИ.', cause: e));
    }

    final name = _asString(map['name']);
    final concept = _asString(map['concept']);
    final problem = _asString(map['problem']);
    final appearance = _asString(map['appearance']);
    final description = _asString(map['description']);

    final aspectsRaw = map['aspects'];
    if (aspectsRaw is! List || aspectsRaw.length < 3) {
      return const Left(UnknownFailure(message: 'В JSON должно быть ровно 3 аспекта.'));
    }
    final aspects = aspectsRaw.take(3).map((e) => e.toString().trim()).toList();

    return _parseSkills(map['skills']).fold(
      (f) => Left(f),
      (skills) {
        if (!_isValidPyramid(skills.values.toList())) {
          return const Left(UnknownFailure(
            message:
                'Навыки должны образовывать пирамиду Fate: одна +4, две +3, две +2, одна +1 (значения 3,2,2,1,1,0).',
          ));
        }
        return _parseStunts(map['stunts']).fold(
          (f) => Left(f),
          (stunts) => Right(CharacterAiDraft(
            name: name,
            concept: concept,
            problem: problem,
            appearance: appearance,
            description: description,
            aspects: aspects,
            skills: skills,
            stunts: stunts,
          )),
        );
      },
    );
  }

  static String _stripCodeFence(String s) {
    var t = s;
    if (t.startsWith('```')) {
      final firstNl = t.indexOf('\n');
      if (firstNl != -1) {
        t = t.substring(firstNl + 1);
      }
      final end = t.lastIndexOf('```');
      if (end != -1) {
        t = t.substring(0, end);
      }
    }
    return t.trim();
  }

  static String _asString(Object? v) => v?.toString().trim() ?? '';

  static Either<Failure, Map<SkillType, int>> _parseSkills(Object? raw) {
    if (raw is! Map) {
      return const Left(UnknownFailure(message: 'Поле skills должно быть объектом.'));
    }
    final out = <SkillType, int>{};
    for (final type in SkillType.values) {
      final key = type.name;
      if (!raw.containsKey(key)) {
        return Left(UnknownFailure(message: 'В skills нет ключа "$key".'));
      }
      final v = raw[key];
      final n = v is int ? v : int.tryParse(v.toString());
      if (n == null || n < 0 || n > 3) {
        return Left(UnknownFailure(message: 'Некорректное значение навыка для $key.'));
      }
      out[type] = n;
    }
    return Right(out);
  }

  static bool _isValidPyramid(List<int> values) {
    if (values.length != 6) return false;
    final a = List<int>.from(values)..sort();
    final b = List<int>.from(_pyramidMultiset)..sort();
    for (var i = 0; i < 6; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static Either<Failure, List<({StuntType type, String description})>> _parseStunts(
    Object? raw,
  ) {
    if (raw is! List) {
      return const Left(UnknownFailure(message: 'Поле stunts должно быть массивом.'));
    }
    final items = raw.take(3).toList();
    if (items.length < 3) {
      return const Left(UnknownFailure(message: 'Нужно ровно 3 трюка.'));
    }
    final out = <({StuntType type, String description})>[];
    for (final item in items) {
      if (item is! Map) {
        return const Left(UnknownFailure(message: 'Элемент stunts должен быть объектом.'));
      }
      final m = Map<String, dynamic>.from(item);
      final typeStr = m['type']?.toString().trim() ?? '';
      final desc = _asString(m['description']);
      final stuntType = _parseStuntType(typeStr);
      if (stuntType == null) {
        return Left(UnknownFailure(message: 'Неизвестный тип трюка: $typeStr'));
      }
      out.add((type: stuntType, description: desc));
    }
    return Right(out);
  }

  static StuntType? _parseStuntType(String s) {
    final normalized = s.toLowerCase().replaceAll('-', '_');
    if (normalized == 'one_time' || normalized == 'onetime') {
      return StuntType.oneTime;
    }
    for (final v in StuntType.values) {
      if (v == StuntType.oneTime) continue;
      if (v.name.toLowerCase() == normalized) return v;
    }
    return null;
  }
}
