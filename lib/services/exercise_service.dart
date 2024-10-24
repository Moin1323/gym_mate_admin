import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/models/exercise/instruction.dart';

class ExerciseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, List<Exercise>>> fetchAllExercises() async {
    // Ensure the keys match the case used in your Firestore data
    Map<String, List<Exercise>> categorizedExercises = {
      "Boxing": [],
      "Gym": [], // Normalizing "Strength" as "Gym"
      "Cardio": [],
    };

    try {
      // Fetch all exercises from Firestore
      QuerySnapshot snapshot =
          await _firestore.collectionGroup("exercises").get();

      // Loop through the documents and categorize them
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Normalize category name
        String category = data['category'];
        if (category == "Strength") {
          category = "Gym";
        }

        List<Instruction> instructions = (data['instructions'] as List)
            .map((instruction) => Instruction.fromJson(instruction))
            .toList();

        Exercise exercise = Exercise(
          name: data['name'],
          category: category, // Use the normalized category
          muscleGroup: data['muscleGroup'],
          equipment: data['equipment'],
          animationUrl: data['animationUrl'],
          difficulty: data['difficulty'],
          instructions: instructions,
        );

        // Print the category to check its value
        print("Exercise category: ${exercise.category}");

        // Add exercise to the appropriate category list
        if (categorizedExercises.containsKey(exercise.category)) {
          categorizedExercises[exercise.category]?.add(exercise);
        } else {
          print("Category not found: ${exercise.category}");
        }
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    }

    return categorizedExercises;
  }
}
