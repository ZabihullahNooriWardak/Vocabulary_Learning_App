import 'package:get/get.dart';

import '../database/app_db.dart';
import '../repository/vocabulary_repository.dart';

class VocabularyController extends GetxController {
  final VocabularyRepository _vocabularyRepository = VocabularyRepository();
  List<VocabularyData> _allVocabularies = [];

  List<VocabularyData> get allVocabularies => _allVocabularies;

  bool _checkBoxState = false;
  bool get checkBoxValue => _checkBoxState;
  setCheckBoxValue() {
    _checkBoxState = !_checkBoxState;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllVocabularies();
  }

  getAllVocabularies() async {
    _allVocabularies = await _vocabularyRepository.allVocabularies();
    print("this is the length of All Vocabularies  :");
    print(_allVocabularies.length);
    update();
  }

  addVocabulary(VocabularyCompanion vc) async {
    var result = await _vocabularyRepository.addVocabulary(vc);
    print("this is the result after Saving : $result");
    getAllVocabularies();
  }

  updateVocabulary(VocabularyCompanion vc) async {
    await _vocabularyRepository.updateVocabulary(vc);
    getAllVocabularies();
  }

  deleteVocabulary(int id) async {
    await _vocabularyRepository.deleteVocabulary(id);
    getAllVocabularies();
  }
}
