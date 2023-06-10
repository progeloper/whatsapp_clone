import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

import '../../../models/chat.dart';
import '../../../theme/palette.dart';

class ChatTile extends ConsumerStatefulWidget {
  final Chat convo;
  const ChatTile({Key? key, required this.convo}) : super(key: key);

  @override
  ConsumerState createState() => _ChatTileState();
}

class _ChatTileState extends ConsumerState<ChatTile> {
  String getChatName({required String uid, required List<String> members}) {
    if (members.length == 2) {
      members.remove(uid);
      return members[0];
    }
    return widget.convo.name;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);

    return Container(
      height: MediaQuery.of(context).size.height / 12,
      color: Palette.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.convo.avatar),
            backgroundColor: Palette.lightGreyColor,
            radius: 40,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getChatName(uid: user!.uid, members: widget.convo.members),
                style: TextStyle(
                  color: Palette.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.convo.lastMessage.message,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Palette.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          Flexible(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat.jm()
                    .format(widget.convo.lastMessage.time.toDate())
                    .toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
