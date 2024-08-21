import 'features/characters/domain/usecases/save_new_character_test.dart'
    as save_new_character_test;

import 'features/characters/data/datasources/characters_LDS_impl_test.dart'
    as characters_lds_impl_test;

import 'features/characters/data/repositories/character_repository_test.dart'
    as character_repository_test;


void main() {
  save_new_character_test.main();
  character_repository_test.main();
  characters_lds_impl_test.main();
  
}
