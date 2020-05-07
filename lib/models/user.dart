part of 'model.dart';

class User extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  User({
    this.userId,
    this.email,
    this.name,
    this.profilePicture,
    this.selectedGenres,
    this.selectedLanguage,
    this.balance,
  });

  User copyWith({String name, String profilePicture, int balance}) {
    return User(
      name: name ?? this.name,
      email: this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      selectedGenres: this.selectedGenres,
      selectedLanguage: this.selectedLanguage,
      balance: balance ?? this.balance,
      userId: this.userId,
    );
  }

  @override
  List<Object> get props => [
        userId,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguage,
        balance,
      ];

  @override
  String toString() {
    return '[$userId] - $name, $email';
  }
}
