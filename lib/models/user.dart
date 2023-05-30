import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String name;
  final String number;
  final String displayPic;
  final String about;
  final List statusPosts;
  final bool isOnline;
  final Timestamp lastOnline;

//<editor-fold desc="Data Methods">
  const User({
    required this.name,
    required this.number,
    required this.displayPic,
    required this.about,
    required this.statusPosts,
    required this.isOnline,
    required this.lastOnline,
  });


  User copyWith({
    String? name,
    String? number,
    String? displayPic,
    String? about,
    List? statusPosts,
    bool? isOnline,
    Timestamp? lastOnline,
  }) {
    return User(
      name: name ?? this.name,
      number: number ?? this.number,
      displayPic: displayPic ?? this.displayPic,
      about: about ?? this.about,
      statusPosts: statusPosts ?? this.statusPosts,
      isOnline: isOnline ?? this.isOnline,
      lastOnline: lastOnline ?? this.lastOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'number': this.number,
      'displayPic': this.displayPic,
      'about': this.about,
      'statusPosts': this.statusPosts,
      'isOnline': this.isOnline,
      'lastOnline': this.lastOnline,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      number: map['number'] as String,
      displayPic: map['displayPic'] as String,
      about: map['about'] as String,
      statusPosts: map['statusPosts'] as List,
      isOnline: map['isOnline'] as bool,
      lastOnline: map['lastOnline'] as Timestamp,
    );
  }

//</editor-fold>
}