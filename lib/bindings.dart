import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'database/app_db.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppDb());
  }
}
