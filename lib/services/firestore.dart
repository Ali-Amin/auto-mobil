import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAPI {
  final Firestore _fs = Firestore.instance;

  Stream<QuerySnapshot> get brands$ => _fs.collection('carBrands').snapshots();

  DocumentReference getUserDocRef(String userUid) {
    return _fs.collection('users').document(userUid);
  }

  CollectionReference getCarModels(String brandUid) {
    return _fs.collection('carBrands').document(brandUid).collection('models');
  }

  Query getFutureAppointmentsRef() {
    return _fs
        .collection('appointments')
        .where("date", isGreaterThan: DateTime.now().millisecondsSinceEpoch);
  }

  CollectionReference getAppointmentsRef() {
    return _fs.collection('appointments');
  }

  Query getUserAppointmentsRef(String userUid) {
    return _fs.collection('appointments').where('userUid', isEqualTo: userUid);
  }
}
