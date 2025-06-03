import 'package:expense_tracker/repository/category_repository.dart';
import 'package:get/get.dart';

import '../database/app_db.dart';
import '../repository/vocabulary_repository.dart';

class VocabularyController extends GetxController {
  VocabularyController(
      {required this.vocabularyRepository, required this.categoryRepository});
  final VocabularyRepository vocabularyRepository;
  final CategoryRepository categoryRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllVocabularies();
    getAllCategory();
  }

  List<VocabularyData> _allVocabularies = [];

  List<VocabularyData> get allVocabularies => _allVocabularies;

  getAllVocabularies() async {
    _allVocabularies = await vocabularyRepository.allVocabularies();
    update();
    return _allVocabularies;
  }

  addVocabulary(VocabularyCompanion vc) async {
    var result = await vocabularyRepository.addVocabulary(vc);
    print("this is the result after Saving : $result");
    getAllVocabularies();
  }

  updateVocabulary(VocabularyCompanion vc) async {
    await vocabularyRepository.updateVocabulary(vc);
    getAllVocabularies();
  }

  deleteVocabulary(int id) async {
    await vocabularyRepository.deleteVocabulary(id);
    getAllVocabularies();
  }

  VCategoryData? _dropDownSelectedCategory;
  VCategoryData? get dropDownSelectedCategory => _dropDownSelectedCategory;
  setDropDownSelectedCategory(VCategoryData vc) {
    _dropDownSelectedCategory = vc;
    update(['drop_down']);
  }

  getCategoryById(int id) async {
    return await categoryRepository.getCategoryById(id);
  }

  getAllVocabularyByCategory(int id) async {
    _allVocabularies = await getAllVocabularies();
    _allVocabularies = _allVocabularies.where((vocabulary) {
      return vocabulary.categoryId == id;
    }).toList();
    update();
  }

  int? _selectedCategoryId;
  int? get selectedCategoryId => _selectedCategoryId;
  selectCategoryId(int id) {
    _selectedCategoryId = id;
    update();
  }

  List<VCategoryData> _allCategory = [];
  List<VCategoryData> get allCategories => _allCategory;
  getAllCategory() async {
    _allCategory = await categoryRepository.getAllCategory();
    update();
  }
}
