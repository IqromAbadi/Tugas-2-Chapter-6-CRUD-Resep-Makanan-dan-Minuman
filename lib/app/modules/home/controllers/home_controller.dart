import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tugas2_chapter6_crud_resepmakanan/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('Resep');
    return data.orderBy('time', descending: true).snapshots();
  }

  void deleteData(String docID) {
    try {
      Get.defaultDialog(
          title: "Delete Resep",
          middleText: "Apa kamu yakin menghapus resep ini?",
          onConfirm: () async {
            await firestore.collection('Resep').doc(docID).delete();
            Get.back();
            Get.snackbar('Success', 'Data berhasil dihapus');
          },
          textConfirm: "Iya",
          textCancel: "Tidak");
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Tidak bisa menghapus resep ini');
    }
  }
}
