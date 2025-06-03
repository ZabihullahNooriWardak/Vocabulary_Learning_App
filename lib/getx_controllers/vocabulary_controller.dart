import 'package:expense_tracker/repository/category_repository.dart';
import 'package:get/get.dart';

import '../database/app_db.dart';
import '../repository/vocabulary_repository.dart';

class VocabularyController extends GetxController {
  final VocabularyRepository _vocabularyRepository = VocabularyRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<VocabularyData> _allVocabularies = [];
  int? _selectedCategoryId;
  int? get selectedCategoryId => _selectedCategoryId;
  selectCategoryId(int id) {
    _selectedCategoryId = id;
    update();
  }

  List<VocabularyData> get allVocabularies => _allVocabularies;
  List<VCategoryData> _allCategory = [];
  List<VCategoryData> get allCategories => _allCategory;
  getAllCategory() async {
    _allCategory = await _categoryRepository.getAllCategory();
    update();
  }

  getAllVocabulariesById() {
    _allVocabularies = _allVocabularies
        .where((vocabulary) => vocabulary.categoryId == _selectedCategoryId)
        .toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllVocabularies();
    getAllCategory();
  }

  getAllVocabularies() async {
    _allVocabularies = await _vocabularyRepository.allVocabularies();
    update();
    return _allVocabularies;
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

  VCategoryData? _dropDownSelectedCategory;
  VCategoryData? get dropDownSelectedCategory => _dropDownSelectedCategory;
  setDropDownSelectedCategory(VCategoryData vc) {
    _dropDownSelectedCategory = vc;
    update(['drop_down']);
  }

  getCategoryById(int id) async {
    return await _categoryRepository.getCategoryById(id);
  }

  getAllVocabularyByCategory(int id) async {
    _allVocabularies = await getAllVocabularies();
    _allVocabularies = _allVocabularies.where((vocabulary) {
      return vocabulary.categoryId == id;
    }).toList();
    update();
  }
}
