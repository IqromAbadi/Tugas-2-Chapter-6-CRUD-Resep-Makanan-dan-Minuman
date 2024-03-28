import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController ingredientsController;
  late TextEditingController instructionController;
  late TextEditingController timeEstimationController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addData(String title, String ingredients, String instruction,
      String timeEstimation) async {
    try {
      await firestore.collection('Resep').add({
        'title': title,
        'ingredients': ingredients,
        'instruction': instruction,
        'time_estimation': timeEstimation,
        'time': Timestamp.now(),
      });

      Get.back();
      Get.snackbar('Success', 'Data berhasil ditambahkan');
      titleController.clear();
      ingredientsController.clear();
      timeEstimationController.clear();
      instructionController.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    ingredientsController = TextEditingController();
    instructionController = TextEditingController();
    timeEstimationController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    ingredientsController.dispose();
    instructionController.dispose();
    timeEstimationController.dispose();
    super.onClose();
  }
}
