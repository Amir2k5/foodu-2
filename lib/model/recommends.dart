class RecommendModel {
  int? recommendId;
  late String recommendDishName;

  RecommendModel({
    this.recommendId,
    required this.recommendDishName,
  });
  Map<String, dynamic> toMap() {
    {
      return {
        'recommendId': recommendId,
        'recommendDishName': recommendDishName,
      };
    }
  }

  RecommendModel.fromMap(Map<String, dynamic> map) {
    recommendId = map['recommendId'];
    recommendDishName = map['recommendDishName'];
  }
}
