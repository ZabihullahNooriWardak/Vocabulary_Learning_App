import 'package:drift/drift.dart' as db;
import 'package:expense_tracker/database/app_db.dart';
import 'package:expense_tracker/getx_controllers/vocabulary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVocabulary extends StatelessWidget {
  const AddVocabulary({super.key});

  @override
  Widget build(BuildContext context) {
    VocabularyController controller = Get.put(VocabularyController());
    GlobalKey<FormState> _formKey = GlobalKey();
    TextEditingController _wordController = TextEditingController();
    TextEditingController _definitionController = TextEditingController();
    TextEditingController _exampleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Vocabulary"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "this can't be empty";
                  }
                },
                controller: _wordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Word"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "this can't be empty";
                  }
                },
                controller: _definitionController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter definition"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _exampleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter example for it"),
              ),
            ),
            GetBuilder<VocabularyController>(
                init: controller,
                builder: (controller) {
                  return Checkbox(
                      value: controller.checkBoxValue,
                      onChanged: (v) {
                        controller.setCheckBoxValue();
                      });
                }),
            ElevatedButton(
                onPressed: () async {
                  late VocabularyCompanion vc;
                  if (_formKey.currentState!.validate()) {
                    vc = VocabularyCompanion(
                        word: db.Value(_wordController.text),
                        definition: db.Value(_definitionController.text),
                        exampleSentence: db.Value(_exampleController.text == ""
                            ? null
                            : _exampleController.text),
                        mastered: db.Value(controller.checkBoxValue));
                  }
                  await controller.addVocabulary(vc);
                  Navigator.pop(context);
                },
                child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
