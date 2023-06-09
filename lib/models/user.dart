import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String name;
  final String uid;
  final String number;
  final String displayPic;
  final String about;
  final List<String> contacts;
  final List<String> statusPosts;
  final bool isOnline;
  final Timestamp lastOnline;

//<editor-fold desc="Data Methods">
  const User({
    required this.name,
    required this.uid,
    required this.number,
    required this.displayPic,
    required this.about,
    required this.contacts,
    required this.statusPosts,
    required this.isOnline,
    required this.lastOnline,
  });

  User copyWith({
    String? name,
    String? uid,
    String? number,
    String? displayPic,
    String? about,
    List<String>? contacts,
    List<String>? statusPosts,
    bool? isOnline,
    Timestamp? lastOnline,
  }) {
    return User(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      number: number ?? this.number,
      displayPic: displayPic ?? this.displayPic,
      about: about ?? this.about,
      contacts: contacts ?? this.contacts,
      statusPosts: statusPosts ?? this.statusPosts,
      isOnline: isOnline ?? this.isOnline,
      lastOnline: lastOnline ?? this.lastOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'uid': this.uid,
      'number': this.number,
      'displayPic': this.displayPic,
      'about': this.about,
      'contacts': this.contacts,
      'statusPosts': this.statusPosts,
      'isOnline': this.isOnline,
      'lastOnline': this.lastOnline,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      uid: map['uid'] as String,
      number: map['number'] as String,
      displayPic: map['displayPic'] as String,
      about: map['about'] as String,
      contacts: List<String>.from(map['contacts']) ,
      statusPosts: List<String>.from(map['statusPosts']),
      isOnline: map['isOnline'] as bool,
      lastOnline: map['lastOnline'] as Timestamp,
    );
  }

//</editor-fold>
}