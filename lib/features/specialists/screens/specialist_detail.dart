import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/features/hospital/screens/widgets/about/about.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../../common/widgets/button/bottom_button.dart';
import '../../../common/widgets/chips/filter_chip.dart';
import '../../../router.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'widgets/specialist_heading.dart';

class SpecialistDetail extends ConsumerWidget {
  const SpecialistDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = PHelperFunctions.isDarkMode(context);

    final doctor = ref.watch(specialistProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: PCircularIcon(
          backgroundColor: PColors.transparent,
          height: 40,
          width: 50,
          color: isDark ? PColors.light : PColors.dark,
          icon: Icons.arrow_back,
          onPressed: ref.read(goRouterProvider).pop,
        ),
        leadingWidth: 50,
        title: const Text("Doctor Details"),
        actions: [
          PCircularIcon(
            height: 50,
            width: 50,
            icon: Icons.share,
            onPressed: () {},
          ),
          const SizedBox(
            width: 6,
          ),
          PCircularIcon(
            height: 50,
            width: 50,
            icon: Iconsax.heart,
            onPressed: () {},
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.spaceBtwItems),
          child: Column(
            children: [
              SpecialistHeading(
                doctor: doctor,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpecialistDetailButton(
                    iconData: Iconsax.people5,
                    onPressed: () {},
                    title: doctor.noOfPatients,
                    subTitle: 'Patients',
                  ),
                  SpecialistDetailButton(
                    iconData: Iconsax.calendar5,
                    onPressed: () {},
                    title: doctor.yearOfExp,
                    subTitle: 'years Exp',
                  ),
                  SpecialistDetailButton(
                    iconData: Iconsax.call5,
                    onPressed: () {},
                    title: doctor.rating.toString(),
                    subTitle: 'Rating',
                  ),
                  SpecialistDetailButton(
                    iconData: Iconsax.map_15,
                    onPressed: () {},
                    title: '1000',
                    subTitle: 'Review',
                  ),
                ],
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              const AboutDetail(
                usePadding: false,
                tabPadding: EdgeInsets.symmetric(vertical: PSizes.sm),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        // height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: PSizes.spaceBtwItems,
            ),
            PCircularIcon(
              icon: Iconsax.message5,
              height: 60,
              width: 60,
              size: PSizes.lg + 4,
              color: PColors.primary,
              onPressed: () async {
                await ref.read(userController).fetchADoctorRecord(doctor.id);
                ref.read(userChatProvider.notifier).state =
                    ref.read(specialistUserModelProvider);
                ref.read(goRouterProvider).goNamed('chatHolder');
              },
            ),
            Expanded(
              child: BottomButton(
                text: "Book Appointment",
                onTap: () => picker.DatePicker.showDateTimePicker(context,
                    theme: picker.DatePickerTheme(
                      backgroundColor: isDark ? PColors.black : PColors.light,
                      containerHeight: 250,
                      itemHeight: 40,
                      itemStyle: Theme.of(context).textTheme.labelLarge!,
                      cancelStyle: Theme.of(context).textTheme.titleLarge!,
                      doneStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: PColors.primary),
                    ), onConfirm: (dateTime) {
                  debugPrint(
                    dateTime.toLocal().toString(),
                  );
                  return ref.read(goRouterProvider).pushNamed("patientDetail");
                }, onCancel: () {
                  debugPrint("cancelled");
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HOSPITAL DETAILS BUTTON
class SpecialistDetailButton extends StatelessWidget {
  const SpecialistDetailButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.title,
    required this.subTitle,
  });
  final IconData iconData;
  final Function() onPressed;
  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonChip(
          iconData: iconData,
          onSelected: onPressed,
          textSize: 2,
          textWeight: 2,
          spaceBtwBtn: -4,
          isNotSpecialist: false,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.apply(
                color: PColors.primary,
                fontWeightDelta: -1,
                fontSizeDelta: 3,
              ),
        ),
        Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
