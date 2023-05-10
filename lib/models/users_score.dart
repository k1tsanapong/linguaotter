import 'package:cloud_firestore/cloud_firestore.dart';

class UserScore{
  final String? uid;
  final String? fullName;
  final String? email;
  final int? score;
  final String? photoURL;

  UserScore({
    this.uid,
    this.fullName,
    this.email,
    this.score,
    this.photoURL,
});

  String toString() {
    return """
    UID = ${uid}
    Full Name = ${fullName}
    Email = ${email}
    Score = ${score}
    PhotoURL = ${photoURL}
    """;
  }

  factory UserScore.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return UserScore(
      uid: data?['uid'],
      fullName: data?['fullName'],
      email: data?['email'],
      score: data?['score'],
      photoURL:data?['photoURL'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (fullName != null) "fullName": fullName,
      if (email != null) "email": email,
      if (score != null) "score": score,
    };
  }
}