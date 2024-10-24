import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_mate_admin/models/equipments/equipments.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TO UPLOAD DATA
  void uploadAllEquipments(List<Equipment> equipments) {
    for (var equipment in equipments) {
      _firestore
          .collection(
              "Equipments") // Make sure the collection name matches exactly
          .add(equipment.toJson())
          .then((_) {
        print("Equipment '${equipment.name}' uploaded successfully!");
      }).catchError((error) {
        print("Failed to upload equipment '${equipment.name}': $error");
      });
    }
  }

  // New method to fetch all equipments
  Future<List<Equipment>> fetchAllEquipments() async {
    List<Equipment> equipmentList = [];

    try {
      // Fetch all equipments from Firestore
      QuerySnapshot snapshot = await _firestore.collection("Equipments").get();

      // Loop through the documents and add them to the equipment list
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Equipment equipment =
            Equipment.fromJson(data); // Make sure you have a fromJson method
        equipmentList.add(equipment);
      }
    } catch (e) {
      print("Error fetching equipments: $e");
    }

    return equipmentList;
  }
}
