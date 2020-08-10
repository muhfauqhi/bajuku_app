class ProfileModel {
  final String name;
  final String totalItems;
  final String totalOutfits;
  final String totalPoints;

  ProfileModel(
      {this.name, this.totalItems, this.totalOutfits, this.totalPoints});
  ProfileModel.model(
      this.name, this.totalItems, this.totalOutfits, this.totalPoints);
}
