import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/providers.dart';

import '../../../../authentication/models/user_model.dart';

// class RecorderButton extends StatefulWidget {
//   const RecorderButton({
//     super.key,
//   });

//   @override
//   State<RecorderButton> createState() => _RecorderButtonState();
// }

// class _RecorderButtonState extends State<RecorderButton> {
//   @override
//   Widget build(BuildContext context) {
//     final recordController = ref.watch(recorderController);
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         return ref.watch(recordController.isRecording)
//             ? IconButton(
//                 onPressed: () => recordController.stopRecording(),
//                 icon: const Icon(Iconsax.close_circle))
//             : IconButton(
//                 onPressed: () => recordController.startRecording(),
//                 icon: const Icon(Iconsax.microphone));
//       },
//     );
//     // onPressed: () => recordController.startRecording(),
//     // icon: const Icon(Iconsax.microphone));
//   }
// }

class RecorderButton extends ConsumerStatefulWidget {
  const RecorderButton({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends ConsumerState<RecorderButton> {
  @override
  Widget build(BuildContext context) {
    final recordControler = ref.watch(recorderController);

    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final isRecording = ref.watch(recordControler.isRecording);

        return IconButton(
          onPressed: isRecording
              ? () => recordControler.stopRecording(
                  sender: ref.read(userProvider), receiver: widget.user)
              : () => recordControler.openAudio(),
          icon: Icon(isRecording ? Iconsax.close_circle : Iconsax.microphone),
        );
      },
    );
  }
}
