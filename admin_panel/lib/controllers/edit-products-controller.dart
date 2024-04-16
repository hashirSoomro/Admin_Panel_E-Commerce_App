import 'package:admin_panel/models/product-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProductController extends GetxController {
  ProductModel productModel;
  EditProductController({required this.productModel});
  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRealTimeImages();
  }

  void getRealTimeImages() {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.productId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['productImages'] != null) {
          images.value =
              List<String>.from(data['productImages'] as List<dynamic>);
          update();
        }
      }
    });
  }
}
