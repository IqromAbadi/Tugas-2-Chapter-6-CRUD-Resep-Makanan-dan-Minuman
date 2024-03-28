import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas2_chapter6_crud_resepmakanan/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'User created successfully');
      userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
          title: 'Verify your email',
          middleText:
              'Please verify your email to continue. We have sent you an email verification link.',
          textConfirm: 'OK',
          textCancel: 'Resend',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          onCancel: () {
            userCredential.user!.sendEmailVerification();
            Get.snackbar('Success', 'Email verification link sent');
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
