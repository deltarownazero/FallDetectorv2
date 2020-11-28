import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_detector/models/stats_entity.dart';

class DatabaseService {
  final String mail;
  DatabaseService({this.mail});

  final CollectionReference accCollection = FirebaseFirestore.instance.collection('acc');

  Future updateUserStats(
      String label, int speed, double x, double y, double z, double sum, int step) async {
    var now = new DateTime.now();
    return await accCollection
        .doc('$mail/$label/$now')
        .set({'sum': sum, 'x': x, 'y': y, 'z': z, 'speed': speed, 'step': step});
  }

/*  List<StatsEntity> _statsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return StatsEntity(
        label: doc.data()['label'] ?? '',
        step: doc.data()['step'] ?? 0,
        x: doc.data()['x'] ?? 0,
        y: doc.data()['y'] ?? 0,
        z: doc.data()['z'] ?? 0,
        sum: doc.data()['x'] ?? 0,
        speed: doc.data()['x'] ?? 0,
      );
    }).toList();
  }

  Stream<List<StatsEntity>> get stats {
    return accCollection.snapshots().map(_statsListFromSnapshot);
  }*/

  Future getData() async {
    print('IN FUNCTION');
    QuerySnapshot querySnapshot = await accCollection.get();
    print('docs: ');
    print(querySnapshot.docs);
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      print('IN FOR');
      var a = querySnapshot.docs[i];
      print(a.id);
    }
  }

/*    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      print("DONE");
      snapshot.data().forEach((key, value) {
        print('$key: $value');
      });

      return snapshot.data;
    });
  }*/
}
