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
    await _universidadesCollection.doc(universidad.nit).set(universidad.toFirestore());
  }

  Future<void> updateUniversidad(String nit, Universidad universidad) async {
    await _universidadesCollection.doc(nit).set(universidad.toFirestore());
  }

  Future<void> deleteUniversidad(String nit) async {
    await _universidadesCollection.doc(nit).delete();
  }
}