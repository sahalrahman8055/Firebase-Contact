import 'package:contacts/helper/color.dart';
import 'package:contacts/view/add/screen_add.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final List<Color> letterColor = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
  ];

  final CollectionReference contact =
      FirebaseFirestore.instance.collection('Contact');

  void deleteContact(docId) {
    contact.doc(docId).delete();
  }

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
      body: StreamBuilder(
        stream: contact.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot contactSnap = snapshot.data.docs[index];
                String firstLetter = contactSnap['name'][0].toUpperCase();
                Color selectedColor = letterColor[index % letterColor.length];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              spreadRadius: 3)
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
                              contactSnap['name'],
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              contactSnap['phone'].toString(),
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
                                        'name': contactSnap['name'],
                                        'phone':
                                            contactSnap['phone'].toString(),
                                        'id': contactSnap.id,
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () {
                                  deleteContact(contactSnap.id);
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
          }
          return Container();
        },
      ),
    );
  }
}
