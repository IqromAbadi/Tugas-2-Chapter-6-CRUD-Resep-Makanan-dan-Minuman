import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController ingredientsController;
  late TextEditingController instructionController;
  late TextEditingController timeEstimationController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('Resep').doc(docID);
    return docRef.get();
  }

  void updateData(
    String docID,
    String title,
    String ingredients,
    String instruction,
    String timeEstimation,
  ) async {
    try {
      await firestore.collection('Resep').doc(docID).update({
        'title': title,
        'ingredients': ingredients,
        'instruction': instruction,
        'time_estimation': timeEstimation,
      });

      Get.back();
      Get.snackbar('Success', 'Data updated successfully');
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed updating data');
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
