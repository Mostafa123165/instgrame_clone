class UserEntities {
  late String token;
  late String image;
  late  String bio;
  late String cover;
  late String email;
  late String name;
  late String phone;
  late bool verify;

  UserEntities(
      {
        required this.token,
        required this.image,
        required this.bio,
        required this.cover,
        required this.email,
        required this.name,
        required this.phone,
        required this.verify});
}