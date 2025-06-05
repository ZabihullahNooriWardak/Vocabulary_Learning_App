import 'package:expense_tracker/screens/add_category_screen.dart';
import 'package:flutter/material.dart';

import '../screens/add_vocabular.dart';

Future<void> showButtonsDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddVocabulary(),
                    ),
                  );
                },
                child: const Text("Add Vocabulary"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCategoryScreen(),
                    ),
                  );
                },
                child: const Text("Add Category"),
              ),
            ],
          ),
        );
      });
}

Future<void> showDeleteDialog(BuildContext context,
    {required Function onAccept}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure to delete ? "),
          actions: [
            TextButton(
              onPressed: () {
                onAccept();
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
}
