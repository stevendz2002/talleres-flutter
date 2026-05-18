import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final CollectionReference _universidadesCollection =
      FirebaseFirestore.instance.collection('universidades');

  Stream<List<Universidad>> getUniversidades() {
    return _universidadesCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Universidad.fromFirestore(doc))
        .toList());
  }

  Future<void> createUniversidad(Universidad universidad) async {
    await _universidadesCollection.add(universidad.toFirestore());
  }

  // Optional: Update and Delete methods if needed for full CRUD
  Future<void> updateUniversidad(String id, Universidad universidad) async {
    await _universidadesCollection.doc(id).update(universidad.toFirestore());
  }

  Future<void> deleteUniversidad(String id) async {
    await _universidadesCollection.doc(id).delete();
  }
}