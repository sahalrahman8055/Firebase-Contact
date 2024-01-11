import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/helper/color.dart';
import 'package:flutter/material.dart';

class ScreenUpdate extends StatefulWidget {
  const ScreenUpdate({super.key});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  TextEditingController contactName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CollectionReference contact =
      FirebaseFirestore.instance.collection('Contact');

  void updateContact(docId) {
    final data = {'name': contactName.text, 'phone': contactNumber.text};

    contact.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    contactName.text = args['name'];
    contactNumber.text = args['phone'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kDarkColor,
        title: const Text(
          "Update Screen",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter name";
                  } else {
                    return null;
                  }
                },
                controller: contactName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Enter name")),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter number";
                  } else {
                    return null;
                  }
                },
                controller: contactNumber,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Enter number")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateContact(docId);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 45))),
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
