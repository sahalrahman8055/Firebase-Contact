import 'package:contacts/controller/addscreen_provider.dart';
import 'package:contacts/helper/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenUpdate extends StatefulWidget {
  const ScreenUpdate({super.key});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddContactProvider>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    provider.contactName.text = args['name'];
    provider.contactNumber.text = args['phone'];
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
                          value.updateContact(docId);
                          Navigator.pop(context);
                          value.contactName.clear();
                          value.contactNumber.clear();
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
            );
          },
        ),
      ),
    );
  }
}
