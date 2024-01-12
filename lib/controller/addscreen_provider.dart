import 'package:contacts/model/contact_model.dart';
import 'package:contacts/services/firebase/contact_services.dart';
import 'package:flutter/material.dart';

class AddContactProvider extends ChangeNotifier {
  AddContactProvider() {
    fetchContact();
  }

  final TextEditingController contactName = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<ContactModel> contacts = [];

  final FirebaseService firebaseServices = FirebaseService();

  Future<void> fetchContact() async {
    contacts = await firebaseServices.fetchTask();

    notifyListeners();
  }

  void addContact() async {
    final _contact =
        ContactModel(id: "", name: contactName.text, phone: contactNumber.text);
    firebaseServices.addContact(_contact);
    await fetchContact();
    notifyListeners();
  }

  Future<void> deleteContact(String docId) async {
    firebaseServices.deleteContact(docId);
    await fetchContact();
    notifyListeners();
  }

  void updateContact(String docId) async {
    final task = ContactModel(
      id: docId,
      name: contactName.text,
      phone: contactNumber.text,
    );
    firebaseServices.updateContact(task);
    await fetchContact();
    notifyListeners();
  }
}
