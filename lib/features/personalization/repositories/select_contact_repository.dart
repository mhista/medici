// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:medici/features/authentication/models/user_model.dart';

// class SelectContactRepository {
//   final FirebaseFirestore firestore;
//   SelectContactRepository({
//     required this.firestore,
//   });

//   Future<List<Contact>> getContacts() async {
//     List<Contact> contacts = [];
//     try {
//       if (await FlutterContacts.requestPermission()) {
//         contacts = FlutterContacts.getContacts(withProperties: true);
//       }
//     } catch (e) {}
//     return contacts;
//   }

//   void selectContact(Contact selectedContact, BuildContext context) async {
//     var userCollectIon = await firestore.collection('Users').get();
//     bool isFound = false;

//     for (var doc in userCollectIon.docs) {
//       var userData = UserModel.fromSnapshot(doc);

//     }
//   }
// }
