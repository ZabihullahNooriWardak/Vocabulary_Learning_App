import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'db_tables.dart';
part 'app_db.g.dart';

// LazyDatabase _openConnection(){
// return LazyDatabase((){
// return driftDatabase(name: 'vocabulary_db');
// });
// }
@DriftDatabase(tables: [Vocabulary, VCategory])
class AppDb extends _$AppDb {
  AppDb([QueryExecutor? executor]) : super(executor ?? _openConnection());
  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
