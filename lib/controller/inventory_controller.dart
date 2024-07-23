import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_item_model.dart';

class InventoryController {
  final FirebaseFirestore firestore;
  final User user;

  InventoryController(this.firestore, this.user);

  Stream<List<InventoryItem>> getItems() {
    return firestore
        .collection('inventory')
        .where('userId', isEqualTo: user.uid)
        .orderBy('name')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => InventoryItem.fromMap(doc.id, doc.data()!)).toList());
  }

  Future<void> addItem(String name) async {
    final items = await firestore
        .collection('inventory')
        .where('userId', isEqualTo: user.uid)
        .where('name', isEqualTo: name.toLowerCase())
        .get();
    if (items.docs.isNotEmpty) {
      throw Exception('Item already exists');
    }

    await firestore.collection('inventory').add({
      'userId': user.uid,
      'name': name.toLowerCase(),
      'quantity': 1,
    });
  }

  Future<void> updateItem(String id, int quantity) async {
    if (quantity <= 0) {
      await firestore.collection('inventory').doc(id).delete();
    } else {
      await firestore.collection('inventory').doc(id).update({'quantity': quantity});
    }
  }
}
