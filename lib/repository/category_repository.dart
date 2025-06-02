import 'package:expense_tracker/database/app_db.dart';
import 'package:expense_tracker/database/db_tables.dart';
import 'package:get/get.dart';

class CategoryRepository {
  final db = Get.find<AppDb>();

  Future<List<VCategoryData>> getAllCategory() async {
    try {
      return await db.select(db.vCategory).get();
    } catch (e) {
      print(e);
      return [];
    }
  }

  addCategory(VCategoryCompanion category) async {
    try {
      await db.into(db.vCategory).insert(category);
    } catch (e) {
      print(e);
    }
  }

  getCategoryById(int id) async {
    try {
      return await (db.select(db.vCategory)
            ..where((category) => category.id.equals(id)))
          .getSingle();
    } catch (e) {}
  }
}
