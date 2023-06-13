import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic_project/paymentGateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class marketplace extends StatefulWidget {
  const marketplace({super.key});

  @override
  State<marketplace> createState() => _marketplaceState();
}

class _marketplaceState extends State<marketplace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to the Farmer\'s Market!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Buy fresh produce directly from farmers!',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          //make a listview of the products
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('market').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              leading: Image.network(
                                snap[index]['ProductImage'],
                                height: 50,
                                width: 50,
                              ),
                              title: Text(snap[index]['Product']),
                              subtitle:
                                  Text('Rs ' + snap[index]['Price'].toString()),
                              trailing: const Icon(Icons.arrow_forward),
                              children: [
                                Text('Sold By: ' + snap[index]['SoldBy']),
                                // Text(snap[index]['StartDate']),
                                // Text(snap[index]['EndDate']),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xFF00C880),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  onPressed: () {
                                    //redirect to payment page
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentGateway()));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Donate',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        // Card(
                        //         child: ListTile(
                        //   leading: Image.network(
                        //               snap[index]['ProductImage'],
                        //               height: 50,
                        //               width: 50,
                        //             ),
                        //   title: Text(snap[index]['Product']),
                        //   subtitle: Text(snap[index]['Price'].toString()),
                        //   trailing: const Icon(Icons.arrow_forward),
                        // ),

                        //       );
                      },
                    );
                  } else {
                    return const Placeholder();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
