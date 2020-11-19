import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String mail;
  DatabaseService(this.mail);

  final CollectionReference accCollection = FirebaseFirestore.instance.collection('acc');

  Future updateUserStats(String label, int speed, double x, double y, double z, double sum) async {
    var now = new DateTime.now();
    return await accCollection
        .doc('$mail/$label/$now')
        .set({'sum': sum, 'x': x, 'y': y, 'z': z, 'speed': speed});
  }
}
