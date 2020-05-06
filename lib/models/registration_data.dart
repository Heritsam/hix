part of 'model.dart';

class RegistrationData {
  String name;
  String email;
  String password;
  List<String> selectedGenres;
  String selectedLanguage;
  File profilePicture;

  RegistrationData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.selectedGenres = const [],
    this.selectedLanguage = '',
    this.profilePicture,
  });
}
