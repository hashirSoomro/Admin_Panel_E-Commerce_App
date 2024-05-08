// ignore_for_file: file_names

import 'package:uuid/uuid.dart';

class GenerateIds {
  String generateProductId() {
    String formattedProductId;
    String uuid = const Uuid().v4();

    //customize id
    formattedProductId = "easy-shopping-${uuid.substring(0, 5)}";
    return formattedProductId;
  }

  String generateCategoryId() {
    String formattedCategoryId;
    String uuid = const Uuid().v4();

    //customize id
    formattedCategoryId = "easy-shopping-${uuid.substring(0, 5)}";
    return formattedCategoryId;
  }
}
