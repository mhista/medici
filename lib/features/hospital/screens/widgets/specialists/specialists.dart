import 'package:flutter/material.dart';
import 'package:medici/common/widgets/headings/tab_headings.dart';
import 'package:medici/features/main_app/screens/home/widgets/doc_card_list.dart';
import 'package:medici/features/main_app/screens/home/widgets/doc_prof_list.dart';

class Specialists extends StatelessWidget {
  const Specialists({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: const [
        TabHeading(
          tabHead: "Specialists",
          count: 10,
        ),
        DoctorCardList(),
      ],
    );
  }
}
