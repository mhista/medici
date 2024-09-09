import 'package:flutter/material.dart';
import 'package:medici/common/widgets/headings/tab_headings.dart';
import 'package:medici/common/widgets/texts/read_more_text.dart';

import '../../../../../utils/constants/sizes.dart';

class AboutDetail extends StatelessWidget {
  const AboutDetail({super.key, this.usePadding = true, this.tabPadding});

  final bool usePadding;
  final EdgeInsets? tabPadding;
  @override
  Widget build(BuildContext context) {
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
            child: const Column(children: [
              PReadMoreText(
                  collapsedTextPrefix: 'Read',
                  text:
                      "lorem lipsum dolore sicyut uiwh egcuiwchuinc iucuincuincuic uicbucnc cic c79hch7c 8c8wch8chc 9chch8chwc 87ch8hcn8c 8ch89c89h  uihdidcuihdc uihwidkncidc uidhidcnuic uihdneui uiedheuide uiieudejkkdnie eined euidbe ceh ecuincuic  uice cuecbie uuci  ciu ecue euc euc wecuy dcc   wuybeyuee  uydguyegwcywececdf tyfdetydtye etydtyed etyfywetvcuweidcuwe wegf8euc wegc8ece76g "),
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
            child: const Column(
              children: [
                Divider(),
                WorkingHour(day: "Monday", startHour: "9:00", endHour: "4:00"),
                WorkingHour(day: "Tuesday", startHour: "9:00", endHour: "4:00"),
                WorkingHour(
                    day: "Wednesday", startHour: "9:00", endHour: "4:00"),
                WorkingHour(
                    day: "Thursday", startHour: "9:00", endHour: "4:00"),
                WorkingHour(day: "Friday", startHour: "9:00", endHour: "4:00"),
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
