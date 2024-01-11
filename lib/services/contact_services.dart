import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/model/contact_model.dart';

class FirebaseService {
  final CollectionReference firebaseContact =
      FirebaseFirestore.instance.collection('Contact');

  Future<List<ContactModel>> fetchTask() async {
    final snapshot = await firebaseContact.get();
    return snapshot.docs.map((doc) {
      return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  void addContact(ContactModel contact) {
    final data = contact.toMap();
    firebaseContact.add(data);
  }

  void updateContact(ContactModel contact) {
    final data = contact.toMap();

    firebaseContact.doc(contact.id).update(data);
  }

  void deleteContact(String docId) {
    firebaseContact.doc(docId).delete();
  }


}
