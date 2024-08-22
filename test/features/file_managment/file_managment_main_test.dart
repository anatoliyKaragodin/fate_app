import 'domain/usecases/file_usecases_test.dart' as file_usecases_test;
import 'data/repositories/file_repository_test.dart' as file_repository_test;
import 'data/datasources/local/file_lds_test.dart' as file_lds_test;

void main() {
  file_usecases_test.main();
  file_repository_test.main();
}
