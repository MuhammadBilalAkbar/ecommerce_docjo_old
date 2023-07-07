import 'package:ecommerce_docjo/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.pId,
  });

  final String productName;
  final String pId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // final fireStoreSnapshots =

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(
          context: context,
          text: '${widget.productName} price',
        ),
        body: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream:
              FirebaseFirestore.instance.collection('products').doc(widget.pId).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) return const Text('Some error');

                Map<String, dynamic> productPrice = snapshot.data!.get('productPrice') as Map<String, dynamic>;
                final productPriceLength = productPrice.keys.length;
                debugPrint(productPriceLength.toString());


                return Expanded(
                  child: ListView.builder(
                    itemCount: productPriceLength,
                    itemBuilder: (context, index) {
                      //   final productPrice = snapshot.data!.get('productPrice.user$index+1');
                        final productPrice = snapshot.data!['productPrice.user${index+1}'];
                        debugPrint(productPrice);
                      return ListTile(
                        title: Text('user${index+1}'),
                        trailing: Text(productPrice.toString()),
                      );
                    },
                  ),
                );


                // debugPrint(snapshot.data?.get('productName'));
                // // debugPrint(snapshot.data?.get(''));
                //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                //   debugPrint('${data.keys.toList().length}');
                //   debugPrint(data.toString());

                // print(FirebaseFirestore.instance.collection('products').doc(widget.pId).get().then((snhot) {
                //   final data = snhot.data() as Map<String, dynamic>;
                //   print('data: ${data.toString()}');
                // }));

                // print('count ${FirebaseFirestore.instance.collection('products').count()}');


                // debugPrint('total products ${snapshot.data!.docs.length}');
                //
                // for (var element in snapshot.data!.docs) {
                //   print('element Reference: ${element.reference.path}');
                //
                //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                //
                //   // final data = element.data();
                //   print('data $data');
                //   final productName = element.get('productName');
                //   print('productName $productName');
                //   final productPrice = element.get('productPrice');
                //   print('productPrice $productPrice');
                //   final productPriceUser4 = element.get('productPrice.user4');
                //   print('productPrice user4 $productPriceUser4');
                //   // final length = productPrice as Map<String, dynamic>.keys.toList().length();
                //   // print('productPrice $productPrice');
                // }
                // return Expanded(
                //   child: ListView.builder(
                //     itemCount: snapshot.data!.docs.length,
                //     itemBuilder: (context, index) {
                //       final String productName =
                //           snapshot.data!.docs[index]['productName'];
                //
                //       final productPrice =
                //           snapshot.data!.docs[index]['productPrice'];
                //
                //       // final String? productId =
                //       //     snapshot.data?.docs[index].reference.id;
                //
                //       debugPrint('productName: $productName');
                //       debugPrint('productPrice: $productPrice');
                //
                //       return Column(
                //         children: [
                //           ListTile(
                //             title: Text(' Price'),
                //             trailing: Text('123456789098765432'),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // );
              },
            ),
          ],
        ),
      );
}
