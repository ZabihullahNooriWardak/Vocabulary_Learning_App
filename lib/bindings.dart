import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'database/app_db.dart';
//
// GetIt locator = GetIt.instance;
//
//     void setUp(){
//   locator.registerLazySingleton(()=>AppDb());
//     }

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppDb());
  }
}
