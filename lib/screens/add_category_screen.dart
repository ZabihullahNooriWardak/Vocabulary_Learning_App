import 'package:drift/drift.dart' as db;
import 'package:expense_tracker/database/app_db.dart';
import 'package:expense_tracker/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controllers/vocabulary_controller.dart';

class AddCategoryScreen extends GetView<VocabularyController> {
  AddCategoryScreen({super.key});

  final TextEditingController categoryController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "this can't be empty";
                  }
                  return null;
                },
                controller: categoryController,
                decoration: const InputDecoration(
                    label: Text("Category"),
                    border: OutlineInputBorder(),
                    hintText: "Enter Category"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    final categoryCompanion = VCategoryCompanion(
                      name: db.Value(categoryController.text),
                    );
                    await CategoryRepository().addCategory(categoryCompanion);
                    controller.getAllCategory();
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add Category"))
          ],
        ),
      ),
    );
  }
}
