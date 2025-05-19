import 'package:expense_tracker/getx_controllers/vocabulary_controller.dart';
import 'package:expense_tracker/screens/add_vocabular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocabularyHome extends StatelessWidget {
  const VocabularyHome({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());
    // print('this is in build method : ${controller.allVocabularies[0].word}');
    // TODO: implement build
    return GetBuilder<VocabularyController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddVocabulary(),
                ),
              );
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
          body: controller.allVocabularies.isEmpty
              ? const Center(child: Text("no vocabulary or word"))
              : ListView.builder(
                  itemCount: controller.allVocabularies.length,
                  itemBuilder: (context, index) {
                    var vocabularyData = controller.allVocabularies[index];
                    return ListTile(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Are you sure to delete ? "),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await controller
                                          .deleteVocabulary(vocabularyData.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              );
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
        );
      },
    );
  }
}
//
