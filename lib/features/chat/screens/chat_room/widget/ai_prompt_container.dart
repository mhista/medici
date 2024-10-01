import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/features/chat/controllers/chat_controller.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:medici/utils/constants/sizes.dart';

class AiPromptContainer extends ConsumerWidget {
  const AiPromptContainer({super.key});

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiver = ref.watch(userChatProvider);
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
          Column(
            children: [
              Text(
                'seems Dr ${receiver.lastName} is currently offline, but don’t worry! You can chat with our AI assistant for any immediate questions or concerns. The AI is here to help you while you wait for the doctor to come online. ',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: PColors.light),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => ref.read(showBotPrompt.notifier).state = false,
                    child: TRoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      backgroundColor: Colors.red,
                      child: Text(
                        "No",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: PColors.light),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: PSizes.sm,
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(goRouterProvider).goNamed('aiChat');
                      ref.read(aiChatController).sendFirstTextMessage();
                    },
                    child: TRoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      backgroundColor: PColors.primary,
                      child: Text(
                        "Yes",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: PColors.light),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: PSizes.spaceBtwItems,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
