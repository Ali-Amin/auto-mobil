import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAPI {
  final Firestore _fs = Firestore.instance;

  Stream<QuerySnapshot> get brands$ => _fs.collection('carBrands').snapshots();

  DocumentReference getUserDocRef(String userUid) {
    return _fs.collection('users').document(userUid);
  }
}
