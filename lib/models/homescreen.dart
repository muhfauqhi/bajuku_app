class HomeScreenModel {
  final int clothesCount;
  final DateTime memberSince;
  final Set<Map<String, Object>> categories;

  HomeScreenModel({this.clothesCount, this.memberSince, this.categories});
  HomeScreenModel.model(this.clothesCount, this.memberSince, this.categories);
}
