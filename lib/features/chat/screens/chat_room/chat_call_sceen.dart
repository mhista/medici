import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
import 'package:medici/providers.dart';

class CallChatPlaceHolder extends ConsumerWidget {
  const CallChatPlaceHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<CallModel>(
        stream: ref.read(callController).callStream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data != CallModel.empty()) {
            CallModel call = snapshot.data ?? CallModel.empty();
            if (!call.hasDialled) {
              return Container();
            }
          }
          return const ChatRoom();
        });
  }
}
