import 'package:ecommerce_docjo/screens/product_detail_screen.dart';
import 'package:ecommerce_docjo/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final FirebaseAuth logOutAuth = FirebaseAuth.instance;
  final editController = TextEditingController();

  final fireStoreSnapshots =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(
          context: context,
          text: 'All Products',
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStoreSnapshots,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
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
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductDetailScreen(
                                productName: productName,
                                pId: productId!,
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
