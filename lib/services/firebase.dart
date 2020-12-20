import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_detector/models/stats_entity.dart';
import 'package:fall_detector/utils/constants.dart';

class FirebaseService {
  final String mail;
  FirebaseService({this.mail});

  final CollectionReference accCollection = FirebaseFirestore.instance.collection('acc');

  Future updateUserStats(
      String label, double speed, double x, double y, double z, double sum, int step) async {
    var now = new DateTime.now();
    return await accCollection.doc('$now').set({
      'sum': sum,
      'x': x,
      'y': y,
      'z': z,
      'speed': speed,
      'step': step,
      'label': label,
      'user': mail,
      'time': now.toString(),
    });
  }

  Future<List<StatsEntity>> getStatsFromFirebase(String label) async {
    QuerySnapshot querySnapshot = await accCollection
        .where('label', isEqualTo: label)
        .orderBy('time')
        .limitToLast(AppConstants.firebaseStatsLimit)
        .get();
    List<StatsEntity> statsList = new List();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var stats = querySnapshot.docs[i];
      statsList.add(new StatsEntity.fromJson(stats.data()));
    }
    return statsList;
  }
}
