import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LaCourtsFirebaseUser {
  LaCourtsFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

LaCourtsFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LaCourtsFirebaseUser> laCourtsFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LaCourtsFirebaseUser>(
            (user) => currentUser = LaCourtsFirebaseUser(user));
