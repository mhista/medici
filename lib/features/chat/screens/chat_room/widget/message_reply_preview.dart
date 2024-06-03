import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:medici/utils/constants/sizes.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview(
      {this.messageOwner, required this.messageReply, super.key});
  final MessageReply messageReply;
  final String? messageOwner;

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 30, bottom: 4, top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: const Border(
          left: BorderSide(color: PColors.primary, width: 5),
          top: BorderSide(color: PColors.primary, width: 0.3),
          bottom: BorderSide(color: PColors.primary, width: 0.5),
          right: BorderSide(color: PColors.primary, width: 0.5),
        ),
      ),
      width: 350,
      padding: const EdgeInsets.only(left: 15, right: 8, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply.isMe ? 'You' : messageOwner ?? 'You',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap: () => cancelReply(ref),
              )
            ],
          ),
          const SizedBox(
            height: PSizes.spaceBtwItems / 2.5,
          ),
          Text(messageReply.messageEnum == MessageType.audio.name
              ? 'Voice message'
              : messageReply.message),
        ],
      ),
    );
  }
}
