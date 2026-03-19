import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

extension EitherTestX<L, R> on Either<L, R> {
  R getRightOrFailTest() {
    return fold(
      (l) => fail('Expected Right, got Left($l)'),
      (r) => r,
    );
  }

  L getLeftOrFailTest() {
    return fold(
      (l) => l,
      (r) => fail('Expected Left, got Right($r)'),
    );
  }
}
