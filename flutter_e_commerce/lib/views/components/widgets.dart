import 'package:flutter/material.dart';

// class BottomNavBar {
//   List buttons = [];
//   int selectedItem = 0;
//   @override
//   Widget build(BuildContext context) {
    // return BottomNavigationBar(
    //   selectedItemColor: Colors.black,
    //   unselectedItemColor: Colors.black,
    //   showUnselectedLabels: false,
    //   showSelectedLabels: false,
    //   currentIndex: currentIndex,
    //   iconSize: 30,
    //   onTap: (i) {
    //     setState(() {
    //       currentIndex = i;
    //     });
    //     if (i == 4 && key.currentState!.hasEndDrawer) {
    //       key.currentState!.openEndDrawer();
    //     }
    //   },
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: icons(
    //         0,
    //         currentIndex,
    //         Icon(Icons.widgets),
    //         Icon(Icons.widgets_outlined),
    //       ),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: icons(
    //         1,
    //         currentIndex,
    //         Icon(Icons.shopping_bag),
    //         Icon(Icons.shopping_bag_outlined),
    //       ),
    //       label: 'Orders',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: icons(
    //         2,
    //         currentIndex,
    //         Icon(Icons.local_grocery_store),
    //         Icon(Icons.local_grocery_store_outlined),
    //       ),
    //       label: 'Cart',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: icons(
    //         3,
    //         currentIndex,
    //         Icon(Icons.favorite),
    //         Icon(Icons.favorite_outline),
    //       ),
    //       label: 'Favourite',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: icons(
    //         4,
    //         currentIndex,
    //         Icon(Icons.person),
    //         Icon(Icons.person_outline),
    //       ),
    //       label: 'Account',
    //     ),
    //   ],
    // );

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Color(0xffdddddd), blurRadius: 6),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.widgets_outlined, size: 30),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.shopping_bag_outlined, size: 30),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.local_grocery_store_outlined, size: 30),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.favorite_outline, size: 30),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.person_outline, size: 30),
//           ),
//         ],
//       ),
//     );
//   }
// }
