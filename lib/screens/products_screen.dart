import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_docjo/screens/edit_price_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'login_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseAuth logOutAuth = FirebaseAuth.instance;
  final editController = TextEditingController();

  final fireStoreSnapshots =
      FirebaseFirestore.instance.collection('products').snapshots();
  final fireStoreCollectionRef =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          actions: [
            IconButton(
              onPressed: () {
                logOutAuth.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                  debugPrint('== Navigating to login_screen.dart');
                }).onError((error, stackTrace) {
                  Utils().showToastMessage(error.toString());
                });
                debugPrint(
                    '== Signing out user ${logOutAuth.currentUser!.email}');
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStoreSnapshots,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return const CircularProgressIndicator();
                if (snapshot.hasError) return const Text('Some error');

                debugPrint('total products ${snapshot.data!.docs.length}');

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final String productName =
                          snapshot.data!.docs[index]['productName'];

                      final String? userEmail = logOutAuth.currentUser?.email;
                      final String? userPriceId =
                          userEmail?.substring(0, userEmail.length - 10);

                      final String productPrice = snapshot.data!.docs[index]
                          ['productPrice'][userPriceId];

                      final String? productId =
                          snapshot.data?.docs[index].reference.id;

                      debugPrint('productName: $productName');
                      debugPrint('productPrice: $productPrice');
                      debugPrint('userPriceId: $userPriceId');
                      debugPrint('productId: $productId');

                      return ListTile(
                        title: Text(productName),
                        trailing: Text(productPrice),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditPriceScreen(
                                productName: productName,
                                productPrice: productPrice,
                                userPriceId: userPriceId!,
                                productId: productId!,
                              ),
                            ),
                          );
                          debugPrint('== Navigating to products_screen.dart');
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
}
