import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/common/widgets/headings/tab_headings.dart';
import 'package:medici/common/widgets/texts/read_more_text.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';

import '../../../../../utils/constants/sizes.dart';

class AboutDetail extends ConsumerWidget {
  const AboutDetail({
    super.key,
    this.usePadding = true,
    this.tabPadding,
  });

  final bool usePadding;
  final EdgeInsets? tabPadding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(specialistProvider);
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          TabHeading(
            tabHead: "About",
            hasCount: false,
            usePadding: usePadding,
            padding: tabPadding,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: usePadding ? PSizes.md : 0,
            ),
            child: Column(children: [
              PReadMoreText(
                  collapsedTextPrefix: 'Read', text: doctor.description),
            ]),
          ),
          const SizedBox(
            width: PSizes.spaceBtwItems,
          ),
          TabHeading(
            tabHead: "Working Hours",
            hasCount: false,
            usePadding: usePadding,
            padding: tabPadding,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: usePadding ? PSizes.md : 0,
            ),
            child: Column(
              children: [
                const Divider(),
                if (doctor.workingHours != null)
                  Column(
                      children: doctor.workingHours!
                          .map((duration) => WorkingHour(
                              day: duration.day,
                              startHour:
                                  '${duration.startTime.hour}:${duration.startTime.minute}',
                              endHour:
                                  "${duration.endTime.hour}:${duration.startTime.minute}"))
                          .toList()),
              ],
            ),
          )
        ]);
  }
}

class WorkingHour extends StatelessWidget {
  const WorkingHour({
    super.key,
    required this.day,
    required this.startHour,
    required this.endHour,
  });
  final String day, startHour, endHour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: PSizes.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(fontSizeFactor: 1.2),
          ),
          Text(
            "${startHour}AM - ${endHour}PM",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(fontSizeFactor: 1.2, fontWeightDelta: 6),
          ),
        ],
      ),
    );
  }
}
