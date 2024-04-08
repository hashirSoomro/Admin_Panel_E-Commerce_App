import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryDropDownController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<Map<String, dynamic>> categoriesList = [];
      querySnapshot.docs.forEach(
        (DocumentSnapshot<Map<String, dynamic>> document) {
          categoriesList.add({
            'categoryId': document.id,
            'categoryName': document['categoryName'],
            'categoryImg': document['categoryImg']
          });
        },
      );

      categories.value = categoriesList;
      update();
    } catch (e) {
      print("Error $e");
    }
  }

  //set Selected Category
  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print("Selected Category ID$selectedCategoryId ");
    update();
  }

  //fetch category name
  Future<String?> getCategoryName(String? categoryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('categories')
          .doc(categoryId)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['categoryName'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  void setCategoryName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    print("selected category name $selectedCategoryName");
  }
}
