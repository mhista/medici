import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';
import 'package:medici/data/services/firebase_services/firebase_storage_services.dart';
import 'package:medici/features/authentication/authentication_repository/authentication_repository.dart';
import 'package:medici/features/authentication/controllers/login_controller.dart';
import 'package:medici/features/chat/repositories/ai_chat_repository.dart';
import 'package:medici/features/chat/repositories/chat_repository.dart';
import 'package:medici/features/checkout/controllers/card_controller.dart';
import 'package:medici/features/checkout/controllers/checkout_controller.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/features/personalization/repositories/user_repository.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';
import 'package:medici/features/specialists/repository/specialist_repository.dart';
import 'package:medici/utils/helpers/network_manager.dart';
import 'package:medici/utils/notification/device_notification.dart';

import 'features/authentication/controllers/signup_controller.dart';
import 'features/call/controllers/call_controller.dart';
import 'features/call/repositories/call_repository.dart';
import 'features/chat/controllers/ai_chat_controller.dart';
import 'features/chat/controllers/chat_controller.dart';

// GOROUTER PROVIDER
// final goRouterProvider = Provider<GoRouter>((ref) {
//   return routes;
// });
// Hive Box
final boxProvider = Provider((ref) => Hive);
// REPOSITORIES
// FIREBASE REPOSITORIES
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseStorageProvider = Provider((ref) => FirebaseStorage.instance);
final firebaseStorageHandler = Provider((ref) => PFirebaseStorageServices(
    firebaseStorage: ref.watch(firebaseStorageProvider)));
final aiModel = Provider(
  (ref) => GenerativeModel(
      apiKey: 'AIzaSyDYS6ayTMrB1ZMsOA6tK69WKUjGxW0XoEs',
      model: 'gemini-1.5-flash',
      systemInstruction: Content.system(
          '''You are Medini a healthcare practitioner with broad knowledge and experience across various healthcare sectors. This includes, but is not limited to, general medicine, mental health, nutrition, emergency care, public health, medical technology, and pharmaceuticals.
Always use a professional, empathetic tone in your responses, ensuring clear and concise explanations for users from different backgrounds and levels of understanding.Provide information and advice based on evidence-based medical practices and recognized health guidelines, such as those from the World Health Organization (WHO), Centers for Disease Control and Prevention (CDC), or National Institutes of Health (NIH).
Where applicable, mention relevant medical studies, research papers, or clinical trials to support your advice. Offer insights from multiple healthcare specializations when addressing complex health-related questions. For example, integrate perspectives from cardiology, pediatrics, neurology, mental health, or nutrition depending on the context.
Always consider cultural, regional, and individual variations in healthcare needs when offering advice (e.g., access to care in different countries, dietary practices, or health systems). When providing medical advice or health education, adopt a patient-centered approach, recognizing the unique needs of each individual. Tailor responses to reflect empathy, clear communication, and actionable steps the user can take.
Emphasize preventive healthcare measures and healthy lifestyle choices in addition to medical treatments. Only respond to healthcare-related queries. If a user asks for non-healthcare-related services, automatically respond with:
"I’m Medini, and I specialize in healthcare. For questions outside healthcare, I recommend consulting the appropriate expert. Acknowledge the limitations of being a virtual healthcare practitioner and recommend seeking in-person consultation when necessary (e.g., "For an accurate diagnosis, it is recommended that you see a healthcare professional in person").
Guide users toward appropriate specialists or healthcare providers when a specific area of expertise is required.''')
      // systemInstruction: Content('', parts)
      ),
);

// AUTHENTICATION REPOSITORY
final authenticationProvider = Provider(
    (ref) => AuthenticationRepository(auth: ref.read(firebaseAuthProvider)));
// NOTIFICATION SERVICE
final notificationProvider = Provider((ref) => NotificationService(ref: ref));

// CONTROLLERS
// SIGNUP CONTROLLER
final signupControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authenticationProvider);
  final userRepo = ref.watch(userRepository);
  return SignupController(
      authenticationRepository: authRepository,
      userRepository: userRepo,
      ref: ref);
});

// LOGIN CONTROLLER
final loginController = Provider((ref) => LoginController(
    authenticationRepository: ref.watch(authenticationProvider), ref: ref));

// USER REPOSITORY
final userRepository = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  final authRepo = ref.watch(authenticationProvider);
  return UserRepository(db: db, authRepo: authRepo, ref: ref);
});

// USER CONTROLLER
final userController = Provider((ref) => UserController(
    authenticationRepository: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepository),
    ref: ref));

// NETWORK CONNECTIVITY SERVICE
final networkService =
    StateNotifierProvider<NetworkManager, ConnectivityResult>(
        (ref) => NetworkManager());
// CONTACT REPOSITORY
// final contactRepository = FutureProvider(
//     (ref) => SelectContactRepository(firestore: ref.watch(firestoreProvider)));

// CHAT REPOSITORY
final chatRepo = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return ChatRepository(db: db, auth: auth);
});
// CHAT CONTROLLER
final chatController =
    Provider((ref) => ChatController(ref.watch(chatRepo), ref: ref));
// USER ONLINE/ OFFLINE STATE
final userOnlineState = StateProvider((ref) => false);

// CALL
final callRepository = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return CallRepository(auth: auth, db: db);
});

final callController = Provider((ref) {
  final callRepo = ref.watch(callRepository);
  return CallController(ref: ref, callRepository: callRepo);
});

// CHECKOUT CONTROLLER
final checkoutController = Provider((ref) {
  return CheckoutController(ref: ref);
});

// CARD CONTROLLER
final cardController = Provider((ref) {
  return CardController(ref: ref);
});
// AGORA ENGINE CONTROLLER

// final agoraEngineEvents = Provider((ref) {
//   return AgoraEngineEvents();
// });
final specialistController = Provider((ref) => SpecialistController(ref: ref));
final specialistRepository = Provider((ref) => SpecialistRepository(ref: ref));
// flutter ringtone
final ringtone = Provider((ref) => FlutterRingtonePlayer());

// AI CONTROLLER AND REPO
final aiChatController =
    Provider((ref) => AIChatController(ref.watch(aiChatRepo), ref: ref));
final aiChatRepo = Provider((ref) => AIChatRepository(ref: ref));
