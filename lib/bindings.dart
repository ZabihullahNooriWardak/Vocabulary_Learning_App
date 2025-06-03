import 'package:expense_tracker/repository/category_repository.dart';
import 'package:expense_tracker/repository/vocabulary_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'database/app_db.dart';
import 'getx_controllers/vocabulary_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppDb());
    Get.put(VocabularyRepository());
    Get.put(CategoryRepository());
    Get.put(VocabularyController(
        vocabularyRepository: Get.find(), categoryRepository: Get.find()));
  }
}
