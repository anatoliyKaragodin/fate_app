import 'domain/usecases/characters_usecases_test.dart'
    as characters_usecases_test;

import 'data/datasources/characters_LDS_impl_test.dart'
    as characters_lds_impl_test;

import 'data/repositories/character_repository_test.dart'
    as character_repository_test;

void main() {
  characters_usecases_test.main();
  character_repository_test.main();
  characters_lds_impl_test.main();
}
