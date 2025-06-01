import 'package:drift/drift.dart' as db;
import 'package:expense_tracker/database/app_db.dart';
import 'package:expense_tracker/getx_controllers/vocabulary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVocabulary extends StatefulWidget {
  final VocabularyData? vd;
  const AddVocabulary({super.key, this.vd});

  @override
  State<AddVocabulary> createState() => _AddVocabularyState();
}

class _AddVocabularyState extends State<AddVocabulary> {
  VocabularyController controller = Get.find<VocabularyController>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _definitionController = TextEditingController();
  final TextEditingController _exampleController = TextEditingController();
  var checkboxValue = false;
  @override
  void initState() {
    if (widget.vd != null) {
      _wordController.text = widget.vd!.word;
      _definitionController.text = widget.vd!.definition;
      if (widget.vd!.exampleSentence != null) {
        _exampleController.text = widget.vd!.exampleSentence!;
      }
      checkboxValue = widget.vd!.mastered;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Vocabulary Learning App"),
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
                  return null;
                },
                controller: _wordController,
                decoration: const InputDecoration(
                    label: Text("word"),
                    border: OutlineInputBorder(),
                    hintText: "Enter Word"),
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
                    label: Text("definition"),
                    border: OutlineInputBorder(),
                    hintText: "Enter definition"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _exampleController,
                decoration: const InputDecoration(
                    label: Text("example"),
                    border: OutlineInputBorder(),
                    hintText: "Enter example for it"),
              ),
            ),
            GetBuilder(
              init: controller,
              id: 'drop_down',
              builder: (controller) {
                return DropdownButton(
                  value: controller.dropDownSelectedCategory,
                  items:
                      List.generate(controller.allCategories.length, (index) {
                    return DropdownMenuItem(
                        value: controller.allCategories[index],
                        child: Text(controller.allCategories[index].name));
                  }),
                  onChanged: (value) {
                    controller.setDropDownSelectedCategory(value!);
                  },
                );
              },
            ),
            GetBuilder<VocabularyController>(
                init: controller,
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text("Is Mastered? : "),
                        Checkbox(
                            value: checkboxValue,
                            onChanged: (v) {
                              checkboxValue = v!;
                              setState(() {});
                            }),
                      ],
                    ),
                  );
                }),
            ElevatedButton(
              onPressed: () async {
                late VocabularyCompanion vc;

                if (widget.vd == null) {
                  if (_formKey.currentState!.validate()) {
                    vc = VocabularyCompanion(
                        word: db.Value(_wordController.text),
                        definition: db.Value(_definitionController.text),
                        exampleSentence: db.Value(_exampleController.text == ""
                            ? null
                            : _exampleController.text),
                        mastered: db.Value(checkboxValue));
                    await controller.addVocabulary(vc);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("word added successfully "),
                      ),
                    );
                  }
                } else {
                  vc = VocabularyCompanion(
                      id: db.Value(widget.vd!.id),
                      word: db.Value(_wordController.text),
                      definition: db.Value(_definitionController.text),
                      exampleSentence: db.Value(_exampleController.text == ""
                          ? null
                          : _exampleController.text),
                      mastered: db.Value(checkboxValue));
                  await controller.updateVocabulary(vc);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("word updated successfully "),
                    ),
                  );
                }
              },
              child:
                  widget.vd != null ? const Text("Update") : const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

//just test for commit
