import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final itemNameController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemQuantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Donate an Item',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add details about the item you want to donate',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: itemNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Item Name',
                    ),
                  ),
                  const SizedBox(height: 20),
                   TextField(
                    controller: itemDescController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Item Description',
                    ),
                  ),
                  const SizedBox(height: 20),
                   TextField(
                    controller: itemQuantityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Item Quantity',
                    ),
                  ),
                  const SizedBox(height: 20),
                  //upload image file
                  SizedBox(
                    height: 60,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF00C880),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () {
                        final itemName = itemNameController.text;
                        final itemDesc = itemDescController.text;
                        final itemQuantity = int.parse(itemQuantityController.text);
                        Publish(itemName: itemName, itemDesc: itemDesc, itemQuantity: itemQuantity);
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Publish Listing',
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
                  ),
                  const SizedBox(height: 20),
                ]),
          ),
        ));
  }

  Future Publish({required String itemName, required String itemDesc, required int itemQuantity}) async {
    //Referece to document
    final docUser =
        FirebaseFirestore.instance.collection('volunteer').doc();
    final item = Item(itemName: itemName, itemDesc: itemDesc, itemQuantity: itemQuantity);  
    final json = item.toJson();
    await docUser.set(json);
  }
}

class Item {
  String itemName;
  String itemDesc;
  int itemQuantity;

  Item({required this.itemName, required this.itemDesc, required this.itemQuantity});
  Map<String, dynamic> toJson() =>
     {
      'itemName': itemName,
      'itemDesc': itemDesc,
      'itemQuantity': itemQuantity,
    };
    static Item fromJson(Map<String, dynamic> json) => Item(
      itemName: json['itemName'],
      itemDesc: json['itemDesc'],
      itemQuantity: json['itemQuantity'],
    );
    }
  

