import 'package:drift/drift.dart' as db;
import 'package:expense_tracker/database/app_db.dart';
import 'package:expense_tracker/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controllers/vocabulary_controller.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final controller = Get.find<VocabularyController>();
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
