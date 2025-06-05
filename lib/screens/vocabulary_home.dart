import 'package:expense_tracker/getx_controllers/vocabulary_controller.dart';
import 'package:expense_tracker/helpers/dialog_helper.dart';
import 'package:expense_tracker/screens/add_vocabular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocabularyHome extends GetView<VocabularyController> {
  const VocabularyHome({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<VocabularyController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showButtonsDialog(context);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text(
              "Vocabulary Learning App",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.allCategories.length + 1,
                    itemBuilder: (context, index) {
                      var color = controller.selectCategoryIndex == index
                          ? Colors.green.shade50
                          : null;
                      if (index == 0) {
                        return InkWell(
                          onTap: () async {
                            await controller.getAllVocabularies();

                            controller.setSelectedCategoryIndex(index);
                          },
                          child: Chip(
                            backgroundColor: color,
                            label: Text(
                              "All",
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () async {
                            await controller.getAllVocabularyByCategory(
                                controller.allCategories[index - 1].id);

                            controller.setSelectedCategoryIndex(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Chip(
                              backgroundColor: color,
                              label: Text(
                                controller.allCategories[index - 1].name,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              ),
              controller.allVocabularies.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text("No vocabulary or word"),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.allVocabularies.length,
                        itemBuilder: (context, index) {
                          var vocabularyData =
                              controller.allVocabularies[index];
                          return ListTile(
                            onLongPress: () {
                              showDeleteDialog(context, onAccept: () async {
                                await controller
                                    .deleteVocabulary(vocabularyData.id);
                                Navigator.pop(context);
                              });
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddVocabulary(
                                    vd: vocabularyData,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              child: Text('${(index + 1)}'),
                            ),
                            title: Text(vocabularyData.word),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(vocabularyData.definition),
                                Text(vocabularyData.exampleSentence ?? ""),
                              ],
                            ),
                            trailing: vocabularyData.mastered
                                ? const Icon(Icons.check)
                                : null,
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
//
