part of 'extension.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({
    String name,
    List<String> selectedGenres = const [],
    String selectedLanguage = 'English',
    int balance = 50000,
  }) {
    return User(
      userId: this.uid,
      email: this.email,
      name: name,
      balance: balance,
      selectedGenres: selectedGenres,
      selectedLanguage: selectedLanguage,
    );
  }

  Future<User> fromFirestore() async {
    return await UserService.getUser(this.uid);
  }
}
