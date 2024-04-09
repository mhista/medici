import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class PFullScreenLoader {
  /*  Open a full screen loading dialog with a given text and animation
  the method does not return anything

  params:
  text: the text to be displayed in a loading dialog
  animation: the lottie animation to be shown
  
   */
  static void openLoadingDialog(
      String text, String animation, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: PHelperFunctions.isDarkMode(Get.context!)
              ? PColors.dark
              : PColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              AnimationLoaderWidget(
                animation: animation,
                text: text,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Stop the currently open loading dialog
  // no return value
  static stopLoading(BuildContext context) {
    Navigator.of(context).pop(); //close the dialog using the navigator
  }
}
