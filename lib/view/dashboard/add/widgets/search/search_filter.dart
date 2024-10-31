import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';
import 'package:gym_mate_admin/models/exercise/exercise.dart';
import 'package:gym_mate_admin/models/exercise/instruction.dart';
import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:gym_mate_admin/res/colors/app_colors.dart';
import 'package:gym_mate_admin/view/dashboard/add/widgets/search/search_textfeild.dart'
    as custom;
import 'package:gym_mate_admin/view/dashboard/details_screens/excersice_datail.dart';
import 'package:gym_mate_admin/view/dashboard/details_screens/equipment_detail.dart';
import 'package:rxdart/rxdart.dart' as rx;

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  // Streams for each collection
  final Stream<QuerySnapshot> _exerciseStream =
      FirebaseFirestore.instance.collectionGroup('exercises').snapshots();
  final Stream<QuerySnapshot> _equipmentStream =
      FirebaseFirestore.instance.collection('Equipments').snapshots();
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  final custom.SearchController controller = Get.put(custom.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.06),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: custom.SearchTextfeild(),
            ),
            SizedBox(height: Get.height * 0.018),
            Expanded(
              child: StreamBuilder<List<QuerySnapshot>>(
                stream: rx.CombineLatestStream.combine3(
                  _exerciseStream,
                  _equipmentStream,
                  _userStream,
                  (QuerySnapshot exerciseSnap, QuerySnapshot equipmentSnap,
                      QuerySnapshot userSnap) {
                    return [exerciseSnap, equipmentSnap, userSnap];
                  },
                ),
                builder: (BuildContext context,
                    AsyncSnapshot<List<QuerySnapshot>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final exerciseDocs = snapshot.data![0].docs;
                  final equipmentDocs = snapshot.data![1].docs;
                  final userDocs = snapshot.data![2].docs;

                  return Obx(() {
                    String searchText =
                        controller.searchText.value.trim().toLowerCase();

                    // Filter exercises
                    List<QueryDocumentSnapshot> filteredExercises =
                        exerciseDocs.where((doc) {
                      String name = doc['name']?.toString().toLowerCase() ?? '';
                      String category =
                          doc['category']?.toString().toLowerCase() ?? '';
                      String muscleGroup =
                          doc['muscleGroup']?.toString().toLowerCase() ?? '';
                      return name.contains(searchText) ||
                          category.contains(searchText) ||
                          muscleGroup.contains(searchText);
                    }).toList();

                    // Filter equipment
                    List<QueryDocumentSnapshot> filteredEquipments =
                        equipmentDocs.where((doc) {
                      String name = doc['name']?.toString().toLowerCase() ?? '';
                      String category =
                          doc['category']?.toString().toLowerCase() ?? '';
                      return name.contains(searchText) ||
                          category.contains(searchText);
                    }).toList();

                    // Filter users
                    List<QueryDocumentSnapshot> filteredUsers =
                        userDocs.where((doc) {
                      String name = doc['name']?.toString().toLowerCase() ?? '';
                      String email =
                          doc['email']?.toString().toLowerCase() ?? '';
                      return name.contains(searchText) ||
                          email.contains(searchText);
                    }).toList();

                    // Combine results
                    List<Map<String, dynamic>> allResults = [
                      ...filteredExercises
                          .map((doc) => {'type': 'exercise', 'data': doc}),
                      ...filteredEquipments
                          .map((doc) => {'type': 'equipment', 'data': doc}),
                      ...filteredUsers
                          .map((doc) => {'type': 'user', 'data': doc}),
                    ];

                    return ListView.builder(
                      itemCount: allResults.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var result = allResults[index];
                        var document = result['data'];
                        String type = result['type'];

                        if (type == 'exercise') {
                          // Create Exercise object
                          Exercise exercise = Exercise(
                            id: document.id,
                            name: document['name'] ?? 'No name',
                            category: document['category'] ?? 'No category',
                            muscleGroup:
                                document['muscleGroup'] ?? 'No muscle group',
                            equipment: document['equipment'] ?? 'No equipment',
                            animationUrl: document['animationUrl'] ?? '',
                            difficulty: document['difficulty'] ?? '',
                            instructions: (document['instructions'] as List)
                                .map((instruction) =>
                                    Instruction.fromJson(instruction))
                                .toList(),
                          );

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ExerciseDetail(exercise: exercise));
                            },
                            child: ListTile(
                              title: Text(
                                exercise.name,
                                style: TextStyle(color: AppColors.secondary),
                              ),
                              subtitle: Text(
                                  'Category: ${exercise.category}\nMuscle Group: ${exercise.muscleGroup}'),
                            ),
                          );
                        } else if (type == 'equipment') {
                          // Create Equipment object
                          Equipment equipment = Equipment(
                            id: document.id,
                            name: document['name'] ?? 'No name',
                            description:
                                document['description'] ?? 'No description',
                            category: document['category'] ?? 'No category',
                            imageUrl: document['imageUrl'] ?? '',
                            availableSizes: document['availableSizes'] != null
                                ? List<String>.from(document['availableSizes'])
                                : null,
                          );

                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => EquipmentDetail(equipment: equipment));
                            },
                            child: ListTile(
                              title: Text(
                                equipment.name,
                                style: TextStyle(color: AppColors.secondary),
                              ),
                              subtitle: Text('Category: ${equipment.category}'),
                            ),
                          );
                        } else {
                          // Create UserModel object
                          UserModel user = UserModel(
                            uid: document.id,
                            name: document['name'] ?? 'No name',
                            email: document['email'] ?? 'No email',
                            cnic: document['cnic'] ?? '',
                            createdAt:
                                (document['createdAt'] as Timestamp).toDate(),
                            token: document['token'] ?? '',
                            role: document['role'] ?? '',
                          );

                          return GestureDetector(
                            onTap: () {
                              //  Get.to(() => UserDetail(user: user));
                            },
                            child: ListTile(
                              title: Text(
                                user.name ?? 'No name',
                                style: TextStyle(color: AppColors.secondary),
                              ),
                              subtitle: Text('Email: ${user.email}'),
                            ),
                          );
                        }
                      },
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
