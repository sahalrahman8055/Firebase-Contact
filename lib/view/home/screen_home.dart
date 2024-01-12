import 'package:contacts/controller/addscreen_provider.dart';
import 'package:contacts/controller/internet_connectivity_provider.dart';
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
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScreenAdd(),
          ));
        },
        backgroundColor: kWhiteColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Consumer<AddContactProvider>(
        builder: (context, value, child) {
          if (value.contacts.isEmpty) {
            Provider.of<InternetConnectivityProvider>(context, listen: false)
                .getInternetConnectivity(context);
            value.fetchContact();
            return const Center(
                child: Text(
              'No Data Found',
              style: TextStyle(color: kWhiteColor),
            ));
          }
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
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: kWhiteColor, blurRadius: 5, spreadRadius: 3)
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
                            backgroundColor: kBackGround,
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
                                color: kBlueColor,
                              )),
                          IconButton(
                              onPressed: () {
                                value.deleteContact(contactModel.id.toString());
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                                color: kRedColor,
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
      ),
    );
  }
}
