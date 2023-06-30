import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class EditPriceScreen extends StatefulWidget {
  const EditPriceScreen({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.userPriceId,
    required this.productId,
  });

  final String productName;
  final String productPrice;
  final String userPriceId;
  final String productId;

  @override
  State<EditPriceScreen> createState() => _EditPriceScreenState();
}

class _EditPriceScreenState extends State<EditPriceScreen> {
  late final TextEditingController priceController;

  final fireStoreCollectionRef =
      FirebaseFirestore.instance.collection('products');

  final logOutAuth = FirebaseAuth.instance;
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.productPrice);

    debugPrint('EditPriceScreen == productName: ${widget.productName}');
    debugPrint('EditPriceScreen == userPriceId: ${widget.userPriceId}');
    debugPrint('EditPriceScreen == productPrice: ${widget.productPrice}');
    debugPrint('EditPriceScreen == docId: ${widget.productId}');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit ${widget.productName} Price ???'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: [
              TextFormField(
                controller: priceController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ${widget.productName} price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide:
                  ),
                  hintText: '${widget.productName} price',
                  labelText: 'Enter ${widget.productName} price',
                ),
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // final String price = snapshot.data!.docs[index]['productPrice']
                  //     [logOutAuth.currentUser!.email];

                  final docRef = FirebaseFirestore.instance
                      .collection('products')
                      // .doc('r3nCVakUA3EM1n2MFzRH');
                      .doc(widget.productId);

                  // debugPrint('editPrice: ${docRef.update({
                  //   'productPrice.${widget.priceId}': '111'
                  //     })}');

                  debugPrint('New price: ${priceController.text}');
                  docRef.update({
                    'productPrice.${widget.userPriceId}': priceController.text
                  }).then((value) {
                    Utils().showToastMessage(
                        'Firebase Firestore Post updated successfully');
                  }).onError((error, stackTrace) {
                    Utils().showToastMessage(error.toString());
                  });
                  Navigator.pop(context);
                },
                child: Text('Save price'),
              ),
            ],
          ),
        ),
      );
}
