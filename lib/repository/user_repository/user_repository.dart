import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/services/equipment_service.dart';
import 'package:gym_mate_admin/view/auth/login/login_view.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var user = UserModel().obs;
  var usersList = <UserModel>[].obs; // To store all users' details
  var exercises =
      <String, List<Exercise>>{}.obs; // For storing categorized exercises
  var equipments = <Equipment>[].obs; // Initialize equipments
  var isLoading = true.obs;
  var singleExercise = Exercise(
    id: '',
    name: "",
    instructions: [],
    category: '',
    muscleGroup: '',
    equipment: '',
    animationUrl: '',
    difficulty: '',
  ).obs; // For storing a single exercise

  final EquipmentService _equipmentService = EquipmentService();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchAllExercises();
    fetchAllEquipments();
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (snapshot.exists) {
          user.value =
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          await _handleLogout();
        }
      } else {
        await _handleLogout();
      }
    } catch (e) {
      print("Error fetching user data: $e");
      await _handleLogout();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      // Query Firestore for users where the status is "user"
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'User')
          .get();

      if (snapshot.docs.isNotEmpty) {
        usersList.value = snapshot.docs
            .map(
                (doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        print("No users with status 'user' found.");
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAll(() => const LoginView());
  }

  Future<void> fetchAllExercises() async {
    isLoading.value = true;
    try {
      Map<String, List<Exercise>> categorizedExercises = {
        "boxing": [],
        "gym": [],
        "cardio": []
      };
      List<String> categories = ['boxing', 'gym', 'cardio'];
      for (String category in categories) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Workouts')
            .doc(category)
            .collection('exercises')
            .get();
        if (snapshot.docs.isNotEmpty) {
          categorizedExercises[category] = snapshot.docs
              .map((doc) =>
                  Exercise.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
        }
      }
      exercises.value = categorizedExercises;
    } catch (e) {
      print("Error fetching exercises: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllEquipments() async {
    isLoading.value = true;
    try {
      equipments.value = await _equipmentService.fetchAllEquipments();
    } catch (e) {
      print("Error fetching equipments: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch equipment data. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSingleExercise(String category, String exerciseId) async {
    isLoading.value = true;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Workouts')
          .doc(category)
          .collection('exercises')
          .doc(exerciseId)
          .get();
      if (snapshot.exists) {
        singleExercise.value =
            Exercise.fromJson(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching single exercise: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectExercise(String category, String exerciseId) async {
    await fetchSingleExercise(category, exerciseId);
    Get.to(() => ExerciseDetail(exercise: singleExercise.value));
  }

  Future<void> deleteExercise(String category, String exerciseId) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('Workouts')
          .doc(category)
          .collection('exercises')
          .doc(exerciseId)
          .delete();
      exercises[category]?.removeWhere((exercise) => exercise.id == exerciseId);
    } catch (e) {
      print("Error deleting exercise: $e");
      Get.snackbar(
        "Error",
        "Failed to delete the exercise. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEquipment(String equipmentId) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('Equipments')
          .doc(equipmentId)
          .delete();
      equipments.removeWhere((equipment) => equipment.id == equipmentId);
    } catch (e) {
      print("Error deleting equipment: $e");
      Get.snackbar(
        "Error",
        "Failed to delete the equipment. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
