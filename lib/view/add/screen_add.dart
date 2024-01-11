import 'package:contacts/controller/addscreen_provider.dart';
import 'package:contacts/helper/color.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

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
        child: Consumer<AddContactProvider>(
          builder: (context, value, child) {
            return Form(
              key: value.formKey,
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
                    controller: value.contactName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter name")),
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
                    controller: value.contactNumber,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter number")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        if (value.formKey.currentState!.validate()) {
                          value.addContact();

                          Navigator.pop(context);

                          value.contactName.clear();
                          value.contactNumber.clear();
                        }
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 45))),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
