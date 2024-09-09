// import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:medici/firebase_options.dart';
import 'package:medici/utils/local_storage/storage_utility.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:medici/utils/notification/device_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';

Future<void> main() async {
  //   Add Widgets Binding
  // final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the timezone
  tz.initializeTimeZones();
  // Init local storage
  // await GetStorage.init();
  // Todo: init payment methods
  //  Await Native Splash
  // Initialize Authentication
  final appDocumentaryDirectory = await getApplicationDocumentsDirectory();
  await HiveService.init(appDocumentaryDirectory.path);
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initial firebase and authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // .then((FirebaseApp value) => Get.put());

// Load all the material design / Themes / Localization / Bindings
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
