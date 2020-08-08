class HomeScreenModel {
  final int clothesCount;
  final String memberSince;
  final Set<Map<String, Object>> categories;
  final String imageUrl;

  HomeScreenModel({this.clothesCount, this.memberSince, this.categories, this.imageUrl});
  HomeScreenModel.model(this.clothesCount, this.memberSince, this.categories, this.imageUrl);
}
