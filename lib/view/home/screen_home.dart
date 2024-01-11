import 'package:contacts/controller/addscreen_provider.dart';
import 'package:contacts/helper/color.dart';
import 'package:contacts/model/contact_model.dart';
import 'package:contacts/view/add/screen_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkColor,
      appBar: AppBar(
        backgroundColor: kDarkColor,
        title: const Text(
          "Contacts",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScreenAdd(),
          ));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Consumer<AddContactProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.contacts.length,
            itemBuilder: (context, index) {
              final ContactModel contactModel =
                  value.contacts.reversed.toList()[index];
              String firstLetter = contactModel.name![0].toUpperCase();
              Color selectedColor = letterColor[index % letterColor.length];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white, blurRadius: 5, spreadRadius: 3)
                      ]),
                  height: 80,
                  // color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 27,
                            child: Text(
                              firstLetter,
                              style: TextStyle(
                                  color: selectedColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contactModel.name!,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            contactModel.phone!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/update',
                                    arguments: {
                                      'name': contactModel.name,
                                      'phone': contactModel.phone,
                                      'id': contactModel.id,
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                value.deleteContact(contactModel.id.toString());
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.red,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        // child: StreamBuilder(
        //   stream: contact.orderBy('name').snapshots(),
        //   builder: (context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       return
        //     }
        //     return Container();
        //   },
        // ),
      ),
    );
  }
}
