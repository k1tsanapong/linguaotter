import 'package:cloud_firestore/cloud_firestore.dart';

class ChinaCharacters {
  final String? character;
  final String? eng_meaning;
  final String? pinyin;
  final String? POS;

  String toString() {
    return "Character = ${character} \n"
        "Meaning = ${eng_meaning} \n"
        "Pinyin = ${pinyin} \n"
        "Part of speech = ${POS} \n";
  }

  ChinaCharacters({
    this.character,
    this.eng_meaning,
    this.pinyin,
    this.POS,
  });

  factory ChinaCharacters.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return ChinaCharacters(
      character: data?['character'],
      eng_meaning: data?['eng_meaning'],
      pinyin: data?['pinyin'],
      POS: data?['POS'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (character != null) "character": character,
      if (eng_meaning != null) "eng_meaning": eng_meaning,
      if (pinyin != null) "pinyin": pinyin,
      if (POS != null) "POS": POS,
    };
  }
}
