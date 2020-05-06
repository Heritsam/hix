part of 'service.dart';

class UserService {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userCollection.document(user.userId).setData({
      'email': user.email,
      'name': user.name,
      'profilePicture': user.profilePicture ?? '',
      'selectedGenres': user.selectedGenres,
      'selectedLanguages': user.selectedLanguage,
      'balance': user.balance,
    });
  }

  static Future<User> getUser(String userId) async {
    DocumentSnapshot snapshot = await _userCollection.document(userId).get();

    return User(
      userId: userId,
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      balance: snapshot.data['balance'],
      profilePicture: snapshot.data['profilePicture'],
      selectedLanguage: snapshot.data['selectedLanguage'],
      selectedGenres: List.from(snapshot.data['selectedGenres']),
    );
  }
}
