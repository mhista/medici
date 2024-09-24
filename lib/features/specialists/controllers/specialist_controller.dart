import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/loaders/loaders.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/specialists/models/specialist_model.dart';
import 'package:medici/providers.dart';

final allSpecialists = StateProvider((ref) => <Doctor>[]);
// SPECIALIST USERMODEL
StateProvider<UserModel> specialistUserModelProvider =
    StateProvider<UserModel>((ref) => UserModel.empty());
// DOCTOR MODEL
StateProvider<Doctor> specialistProvider =
    StateProvider<Doctor>((ref) => Doctor.empty());

class SpecialistController {
  final Ref _ref;

  SpecialistController({required Ref ref}) : _ref = ref {
    fetchAllSpecialists();
  }

  void uploadSpecialistDummy() async {
    // checks for internet
    final isConnected = await _ref.watch(networkService.notifier).isConnected();
    if (!isConnected) {
      PLoaders.errorSnackBar(title: "Network is not connected");
      return; //
    }
    // initiate a loader
    // creates a user model using the specialist models
    // List<Doctor> specialistData = SpecialistDummyData.dummyDoctors;
    // debugPrint(specialistData[0].toString());
    // for (var doctor in specialistData) {
    //   final firstName = doctor.name.split(' ')[1].toLowerCase();
    //   final lastName = doctor.name.split(' ')[2].toLowerCase();
    //   debugPrint("$firstName $lastName");
    //   // signup user to firebase
    //   debugPrint("registeriing ${doctor.name} to firebase");
    //   final userCredential = await _ref
    //       .read(authenticationProvider)
    //       .registerWithEmailAndPassword(doctor.email, "@Diwe1234");

    //   // saves the user model to firestore
    //   await _ref
    //       .read(specialistRepository)
    //       .uploadSpecialistImage(doctor)
    //       .then((img) => doctor.profileImage = img);

    //   final user = UserModel(
    //       id: userCredential.user!.uid,
    //       firstName: firstName,
    //       lastName: lastName,
    //       username: doctor.name,
    //       email: doctor.email,
    //       phoneNumber: doctor.phoneNumber,
    //       profilePicture: doctor.profileImage,
    //       isOnline: false,
    //       isDoctor: true,
    //       onCall: false);
    //   debugPrint("saving ${doctor.name} to firebase");
    //   await _ref.read(userRepository).saveUser(user);

    //   // upload the specialist model to firestor
    //   doctor.id = user.id;
    //   debugPrint("registeriing ${doctor.name} to firebase as specialist");
    //   _ref.read(specialistRepository).createSpecialist(doctor);
    // }
  }

  // FETCH ALL USERS
  fetchAllSpecialists() async {
    try {
      final doctors = await _ref.read(specialistRepository).getAllDoctors();
      return _ref.read(allSpecialists.notifier).update((state) {
        state = doctors;
        return state;
      });
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // FETCH ALL USERS
  fetchSpecialist(String doctorId) async {
    try {
      final doctor =
          await _ref.read(specialistRepository).getDoctorById(doctorId);
      return _ref.read(specialistProvider.notifier).state = doctor;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}

// FETCH ALL Doctors
final fetchAllDoctorsProvider = FutureProvider.autoDispose((ref) {
  final specialistControllerr = ref.watch(specialistController);
  return specialistControllerr.fetchAllSpecialists();
});
