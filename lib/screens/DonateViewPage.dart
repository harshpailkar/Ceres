import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic_project/screens/DonatePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DonateViewPage extends StatefulWidget {
  const DonateViewPage({super.key});

  @override
  State<DonateViewPage> createState() => _DonateViewPageState();
}

class _DonateViewPageState extends State<DonateViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Item>>(
          stream: readItems(),
          builder: (context, snapshot) {
            
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView(
                //children:items.map(buildItem).toList(),
              );
            }
            
            else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));}
            
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}

Widget buildItem(BuildContext context, Item items) {
  return Card(
    child: ListTile(
      // leading: Image.network(
      //   item.image,
      //   height: 50,
      //   width: 50,
     // ),
      title: Text(items.itemName),
      subtitle: Text(items.itemQuantity.toString()),
      trailing: const Icon(Icons.arrow_forward),
    ),
  );
}

Stream<List<Item>> readItems() {
  return FirebaseFirestore.instance.collection('volunteer').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());
}
