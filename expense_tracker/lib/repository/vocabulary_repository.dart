import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../database/app_db.dart';
import '../bindings.dart';

class VocabularyRepository {
// AppDb db = locator.get<AppDb>();
  AppDb db = Get.find<AppDb>();
  Future<List<VocabularyData>> allVocabularies() async {
    try {
      return await db.select(db.vocabulary).get();
    } catch (e) {
      print('this is error : $e');
      return [];
    }
  }

  getVocabularyById(int id) async {
    try {
      return await (db.select(db.vocabulary)
            ..where((vocabulary) => vocabulary.id.equals(id)))
          .getSingle();
    } catch (e) {
      print("this is error :$e");
    }
  }

  addVocabulary(VocabularyCompanion vc) async {
    try {
      return await db.into(db.vocabulary).insert(vc);
    } catch (e) {
      print("this is error : $e");
    }
  }

  updateVocabulary(VocabularyCompanion vc) async {
    try {
      return await db.update(db.vocabulary).replace(vc);
    } catch (e) {
      print("this is the errror : $e");
    }
  }

  deleteVocabulary(int id) async {
    try {
      return await (db.delete(db.vocabulary)..where((vc) => vc.id.equals(id)))
          .go();
    } catch (e) {
      print("This is the error : $e");
    }
  }
}
