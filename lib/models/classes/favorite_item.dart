class FavoriteItem {
  final String id;
  final String title;
  final String iconUrl;
  final String address;
  final String distance;
  final String contact;
  bool isFav;

  FavoriteItem(
      {required this.id,
      required this.title,
      required this.address,
      required this.distance,
      required this.iconUrl,
      required this.contact,
        required this.isFav});
}
