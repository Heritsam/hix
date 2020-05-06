part of 'service.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<AuthServiceResult> signUp({
    String email,
    String password,
    String name,
    List<String> selectedGenres,
    String selectedLanguage,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user.convertToUser(
        name: name,
        selectedLanguage: selectedLanguage,
        selectedGenres: selectedGenres,
      );

      await UserService.updateUser(user);

      return AuthServiceResult(user: user);
    } catch (e) {
      return AuthServiceResult(
        message: e.toString().split(',')[1].trim(),
      );
    }
  }

  static Future<AuthServiceResult> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = await result.user.fromFirestore();

      return AuthServiceResult(user: user);
    } catch (e) {
      return AuthServiceResult(
        message: e.toString().split(',')[1].trim(),
      );
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class AuthServiceResult {
  final User user;
  final String message;

  AuthServiceResult({
    this.user,
    this.message,
  });
}
