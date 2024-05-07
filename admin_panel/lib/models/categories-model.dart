class CategoryModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoryModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  //Serialize the user model instance to JSON map.
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  //create a user model instance from a JSON map
  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryImg: json['categoryImg'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
