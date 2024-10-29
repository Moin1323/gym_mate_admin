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
    id: '', // Initialize ID for single exercise
    name: "",
    instructions: [],
    category: '',
    muscleGroup: '',
    equipment: '',
    animationUrl: '',
    difficulty: '',
  ).obs; // For storing a single exercise

  final EquipmentService _equipmentService =
      EquipmentService(); // Initialize EquipmentService

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchAllExercises(); // Fetch exercises
    fetchAllEquipments(); // Fetch equipment
  }

  Future<void> fetchUserData() async {
    isLoading.value = true; // Start loading
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String userId = currentUser.uid;
        print("Current User ID: $userId");

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (snapshot.exists) {
          user.value =
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          await _handleLogout(); // Handle logout if user data does not exist
        }
      } else {
        await _handleLogout(); // Handle logout if no user is signed in
      }
    } catch (e) {
      print("Error fetching user data: $e");
      await _handleLogout(); // Handle logout on error
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> fetchAllUsers() async {
    isLoading.value = true; // Start loading
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (snapshot.docs.isNotEmpty) {
        // Loop through each user document and add it to usersList
        for (var doc in snapshot.docs) {
          UserModel user =
              UserModel.fromJson(doc.data() as Map<String, dynamic>);
          usersList.add(user);
        }
        print("Users fetched successfully: ${usersList.length}");
      } else {
        print("No users found.");
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> _handleLogout() async {
    // Sign out the user
    await FirebaseAuth.instance.signOut();
    // Optionally clear shared preferences for login status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    // Redirect to login view
    Get.offAll(() => const LoginView()); // Ensure to import your login view
  }

  Future<void> fetchAllExercises() async {
    isLoading.value = true; // Start loading
    try {
      // Initialize categorized exercises
      Map<String, List<Exercise>> categorizedExercises = {
        "boxing": [],
        "gym": [],
        "cardio": [],
      };

      // List of workout categories to fetch exercises from
      List<String> categories = ['boxing', 'gym', 'cardio'];

      // Loop through each category and fetch exercises
      for (String category in categories) {
        print("Fetching exercises for $category..."); // Debugging log

        // Access the subcollection 'exercises' under each category
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Workouts')
            .doc(category)
            .collection('exercises')
            .get();

        // Check if snapshot has documents
        if (snapshot.docs.isEmpty) {
          print("No exercises found for $category."); // Debugging log
          continue;
        }

        // Loop through the fetched documents
        for (var doc in snapshot.docs) {
          if (doc.exists) {
            Exercise exercise =
                Exercise.fromJson(doc.data() as Map<String, dynamic>);

            // Add exercise to the appropriate category
            categorizedExercises[category]?.add(exercise);
            print(
                "Added exercise: ${exercise.name} to $category"); // Debugging log
          } else {
            print(
                "Document ${doc.id} in $category has no data."); // Debugging log
          }
        }
      }

      // Update the observable variable
      exercises.value = categorizedExercises;
      print("Exercises fetched successfully: ${exercises.value}");
    } catch (e) {
      print("Error fetching exercises: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Method to fetch all equipments
  Future<void> fetchAllEquipments() async {
    isLoading.value = true; // Start loading
    try {
      List<Equipment> equipmentList =
          await _equipmentService.fetchAllEquipments();
      equipments.value = equipmentList; // Update the observable variable
      print("Equipments fetched successfully: ${equipments.value}");
    } catch (e) {
      print("Error fetching equipments: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch equipment data. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> fetchSingleExercise(String category, String exerciseId) async {
    isLoading.value = true; // Start loading
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Workouts')
          .doc(category) // Now fetch dynamically from the specified category
          .collection('exercises')
          .doc(exerciseId) // Use exerciseId to fetch
          .get();

      if (snapshot.exists) {
        singleExercise.value =
            Exercise.fromJson(snapshot.data() as Map<String, dynamic>);
        print("Fetched single exercise: ${singleExercise.value.name}");
      } else {
        print("No exercise found for ID: $exerciseId in category: $category");
      }
    } catch (e) {
      print("Error fetching single exercise: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> selectExercise(String category, String exerciseId) async {
    await fetchSingleExercise(
        category, exerciseId); // Fetch the exercise details

    Get.to(() => ExerciseDetail(exercise: singleExercise.value));
  }

  // Function to delete an exercise from Firestore
  Future<void> deleteExercise(String category, String exerciseId) async {
    isLoading.value = true; // Start loading
    try {
      // Query the exercise document by the exerciseId field
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Workouts')
          .doc(category)
          .collection('exercises')
          .doc(exerciseId) // Use exerciseId directly
          .get();

      if (doc.exists) {
        await doc.reference.delete(); // Delete the document

        // Remove the deleted exercise from the local list
        exercises[category]
            ?.removeWhere((exercise) => exercise.id == exerciseId);

        print(
            "Exercise deleted successfully: $exerciseId in category: $category");
      } else {
        print("No exercise found with ID: $exerciseId in category: $category");
      }
    } catch (e) {
      print("Error deleting exercise: $e");
      Get.snackbar(
        "Error",
        "Failed to delete the exercise. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Function to delete equipment from Firestore
  Future<void> deleteEquipment(String equipmentId) async {
    isLoading.value = true; // Start loading
    try {
      // Access the specific equipment document by its unique ID
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('Equipments')
          .doc(equipmentId); // Use ID instead of name

      // Delete the document
      await docRef.delete();

      // Remove the deleted equipment from the local list
      equipments.removeWhere(
          (equipment) => equipment.id == equipmentId); // Use ID for comparison

      print("Equipment deleted successfully: $equipmentId");
    } catch (e) {
      print("Error deleting equipment: $e");
      Get.snackbar(
        "Error",
        "Failed to delete the equipment. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
