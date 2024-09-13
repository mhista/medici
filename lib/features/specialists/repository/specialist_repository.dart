import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/specialists/models/specialist_model.dart';
import 'package:medici/providers.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class SpecialistRepository {
  final Ref _ref;

  SpecialistRepository({required Ref ref}) : _ref = ref;
  // CREATE A SPECIALIST
  Future<void> createSpecialist(Doctor specialist) async {
    // save doctore profile to firestore
    _ref
        .read(firestoreProvider)
        .collection("Specialists")
        .doc(specialist.id)
        .set(specialist.toMap());
  }

  // CREATE A SPECIALIST
  Future<String> uploadSpecialistImage(Doctor specialist) async {
    final storage = _ref.read(firebaseStorageHandler);
    // get image data from asset bundle
    final file = await storage.getImageDataFromAssets(specialist.profileImage);
    // upload image data to firebase storage
    final imageUrl =
        await storage.uploadImageData("Specialists", file, specialist.name);

    return imageUrl;
  }

  // UPDATE A SPECIALIST
  // DELETE A SPECIALIST
  // GET ALL SPECIALIST
  Future<List<Doctor>> getAllDoctors() async {
    try {
      final snapshot =
          await _ref.read(firestoreProvider).collection("Specialists").get();
      final list =
          snapshot.docs.map((doc) => Doctor.fromSnapshot(doc)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // GET SPECIALIST BY ID
  Future<Doctor> getDoctorById(String doctorId) async {
    try {
      final snapshot = await _ref
          .read(firestoreProvider)
          .collection("Specialists")
          .doc(doctorId)
          .get();
      return Doctor.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
  // GET ALL SPECIALIST BY NAME
  // GET ALL SPECIALIST BY SPECIALTY
  // GET ALL SPECIALIST BY LOCATION
  // GET ALL SPECIALIST BY EXPERIENCE
  // GET ALL SPECIALIST BY HOSPITAL
  // GET ALL SPECIALIST BY PRICE RANGE
  // GET ALL SPECIALIST BY REVIEWS
  // GET ALL SPECIALIST BY AVERAGE RATING
  // GET ALL SPECIALIST BY POPULARITY
  // GET ALL SPECIALIST BY POPULARITY RANK
  // GET ALL SPECIALIST BY RECOMMENDATION RANK
  // GET ALL SPECIALIST BY RECENTLY ADDED RANK
  // GET ALL SPECIALIST BY UPDATED RECENTLY RANK
  // GET ALL SPECIALIST BY CREDIT RATING
  // GET ALL SPECIALIST BY MEDICAL CARE RATING
  // GET ALL SPECIALIST BY PRICE PER BED
}
