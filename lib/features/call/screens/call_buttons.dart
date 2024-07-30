import 'package:flutter/material.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/utils/constants/colors.dart';

class CallButtonsContainer extends StatelessWidget {
  const CallButtonsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: PColors.black.withOpacity(0.7),
      child: Column(
        children: [],
      ),
    );
  }
}
