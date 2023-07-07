import 'package:ecommerce_docjo/screens/all_products_screen.dart';
import 'package:ecommerce_docjo/screens/my_products_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 24.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_sharp),
              label: 'My Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'All Products',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) => const CupertinoPageScaffold(
                  child: MyProductsScreen(),
                ),
              );
            case 1:
              return CupertinoTabView(
                builder: (context) => const CupertinoPageScaffold(
                  child: AllProductsScreen(),
                ),
              );
            default:
              return CupertinoTabView(
                builder: (context) => const CupertinoPageScaffold(
                  child: MyProductsScreen(),
                ),
              );
          }
        },
      );
// Scaffold(
//   appBar: AppBar(
//     title: selectedIndex == 0
//         ? const Text('My Products')
//         : const Text('All Products'),
//     actions: [
//       IconButton(
//         onPressed: () {
//           logOutAuth.signOut().then((value) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const LoginScreen(),
//               ),
//             );
//             debugPrint('== Navigating to login_screen.dart');
//           }).onError((error, stackTrace) {
//             Utils().showToastMessage(error.toString());
//           });
//           debugPrint(
//               '== Signing out user ${logOutAuth.currentUser!.email}');
//         },
//         icon: const Icon(Icons.logout),
//       ),
//     ],
//   ),
//   body: Center(
//     child: screens.elementAt(selectedIndex),
//   ),
//   bottomNavigationBar: BottomNavigationBar(
//     iconSize: 48.0,
//     selectedFontSize: 20.0,
//     unselectedFontSize: 16.0,
//     items: const [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.shopping_bag_sharp),
//         label: 'My Products',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.shopping_cart_outlined),
//         label: 'All Products',
//       ),
//     ],
//     currentIndex: selectedIndex,
//     onTap: onItemTapped,
//   ),
// );
}
