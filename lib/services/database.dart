import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String gmail;
  DatabaseService(this.gmail);

  final CollectionReference accCollection = FirebaseFirestore.instance.collection('acc');

  Future updateUserData(String label, int speed, int x, int y, int z, int sum) async {
    return await accCollection
        .doc(gmail)
        .set({'label': label, 'sum': sum, 'x': x, 'y': y, 'z': z, 'speed': speed});
  }
}
