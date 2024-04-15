// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/firebase_options.dart';

import 'app.dart';

Future<void> main() async {
  //   Add Widgets Binding
  // final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // Init local storage
  // await GetStorage.init();
  // Todo: init payment methods
  //  Await Native Splash
  // Initialize Authentication

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initial firebase and authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ).then((FirebaseApp value) => Get.put());

// Load all the material design / Themes / Localization / Bindings
  runApp(
    ProviderScope(
      child: DevicePreview(
        builder: (context) {
          return const App();
        },
      ),
    ),
  );
}
