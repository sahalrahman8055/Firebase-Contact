import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/helper/color.dart';

import 'package:flutter/material.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  TextEditingController contactName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CollectionReference contact =
      FirebaseFirestore.instance.collection('Contact');

  void addContact() {
    final data = {'name': contactName.text, 'phone': contactNumber.text};

    contact.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kDarkColor,
        title: const Text(
          "Add Screen",
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
                      addContact();
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(double.infinity, 45))),
                  child: const Text(
                    "Submit",
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
