import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/colors.dart';
import '../icons/rounded_icons.dart';

class ScrollToBottomButton extends ConsumerStatefulWidget {
  const ScrollToBottomButton(
      {required this.controller, required this.onPressed, super.key});
  final VoidCallback onPressed;
  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScrollToBottomButtonState();
}

class _ScrollToBottomButtonState extends ConsumerState<ScrollToBottomButton> {
  bool scrollControl = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.atEdge) {
        setState(() {
          scrollControl = false;
        });
      } else {
        setState(() {
          scrollControl = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return scrollControl
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RoundedIcon(
                bgColor: const Color.fromARGB(255, 12, 15, 69),
                hasBgColor: true,
                isPositioned: false,
                onPressed: widget.onPressed,
                iconData: Icons.arrow_downward_rounded,
                height: 40,
                width: 40,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
