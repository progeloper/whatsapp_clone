import 'package:flutter/material.dart';

import '../../../models/chat.dart';
import '../../../theme/palette.dart';

class ChatTile extends StatelessWidget {
  final Chat convo;
  const ChatTile({Key? key, required this.convo}) : super(key: key);

  String getChatName({required String uid, required List<String> members}){
    if(members.length == 2){
      members.remove(uid);
      return members[0];
    }
    return convo.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/12,
      color: Palette.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(convo.avatar),
            backgroundColor: Palette.lightGreyColor,
            radius: 32,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(convo.)
            ],
          )
        ],
      ),
    );
  }
}
