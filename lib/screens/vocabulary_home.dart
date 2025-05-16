import 'package:expense_tracker/getx_controllers/vocabulary_controller.dart';
import 'package:expense_tracker/screens/add_vocabular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocabularyHome extends StatelessWidget {
  const VocabularyHome({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());
    print('this is in build method : ${controller.allVocabularies[0].word}');
    // TODO: implement build
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
        backgroundColor: Colors.blue,
        title: const Text("Vocabulary Learning App"),
      ),
      body: controller.allVocabularies.isEmpty
          ? const Center(child: Text("no vocabulary or word"))
          : ListView.builder(
              itemCount: controller.allVocabularies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.allVocabularies[index].word),
                  subtitle: Column(
                    children: [
                      Text(controller.allVocabularies[index].definition),
                      Text(controller.allVocabularies[index].exampleSentence ??
                          ""),
                    ],
                  ),
                  trailing: controller.allVocabularies[index].mastered
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
    );
  }
}
