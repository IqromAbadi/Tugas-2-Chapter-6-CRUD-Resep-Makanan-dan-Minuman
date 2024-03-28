import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas2_chapter6_crud_resepmakanan/app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset link sent to your email');
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar('Error', 'Please enter a valid email');
    }
  }
}
