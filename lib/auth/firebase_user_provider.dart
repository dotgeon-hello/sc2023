import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Sc2023FirebaseUser {
  Sc2023FirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

Sc2023FirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Sc2023FirebaseUser> sc2023FirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Sc2023FirebaseUser>(
      (user) {
        currentUser = Sc2023FirebaseUser(user);
        return currentUser!;
      },
    );
