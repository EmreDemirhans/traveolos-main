import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmap/models/mekan_model.dart';

class Mekan {
  final _firestore = FirebaseFirestore.instance;

  List<MekanModel> mekanList = [];

  List puanlar = [];
  List bkPuanlar = [];

  getMekan() async {
    CollectionReference eventsRef = _firestore.collection('data');

    var sonuc = await eventsRef.get();
    sonuc.docs.forEach((element) {
      mekanList.add(MekanModel.fromJson(element.data()));
    });

    mekanList.forEach((element) {
      puanlar.add(element.puan);
    });

    puanlar.sort();
    bkPuanlar = new List.from(puanlar.reversed);
  }
}
