import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'Americano', 'subTitle': 'Start your day strong with a bold aroma', 'price': 50, 'quantity': 0},
    {'name': 'Latte', 'subTitle': 'A perfect blend of smoothness and sweetness', 'price': 60, 'quantity': 0},
    {'name': 'Mocha', 'subTitle': 'Rich chocolate meets bold coffee for the ultimate treat', 'price': 70, 'quantity': 0},
  ];

  int getTotalPrice() {
    return cartItems.fold(0, (sum, item) {
      final price = item['price'] ?? 0;
      final quantity = item['quantity'] ?? 0;
      return sum + (price as int) * (quantity as int);
    });
  }

  int getDiscount() {
    int total = getTotalPrice();
    return total >= 150 ? 10 : 0;
  }

  int getFinalPrice() {
    return getTotalPrice() - getDiscount();
  }

  void _increment(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 0) {
        cartItems[index]['quantity']--;
      }
    });
  }

  Widget buildHeader() {
    return SizedBox(
      height: 137,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 🔶 พื้นหลัง
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF5D2B1A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),

          // 🔙 Back + Title (จัด Row ปกติ)
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.orangeAccent, size: 24),
                SizedBox(width: 12),
                Text(
                  "My Cart",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // 👜 Floating icon แบบ absolute
          Positioned(
            top: -28,
            right: -40,
            child: Image.asset(
              'assets/smoke.png',
              height: 200,
            ),
          ),
          Positioned(
            top: -0,
            right: 20,
            child: Image.asset(
              'assets/bag.png',
              height: 180,
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2E9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Order Item",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: cartItems.length + 1,
              itemBuilder: (context, index) {
                if (index < cartItems.length) {
                  final item = cartItems[index];
                  return CartItemCard(
                    title: item['name'],
                    subtitle: item['subTitle'] ?? '',
                    price: item['price'].toString(),
                    quantity: item['quantity'],
                    onIncrement: () => _increment(index),
                    onDecrement: () => _decrement(index),
                    onDelete: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                } else {
                  // 🔽 ปุ่มเพิ่มรายการแบบ dotted
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          cartItems.add({
                            'name': 'New Item',
                            'subTitle': 'รายละเอียดเพิ่มเติม',
                            'price': 0,
                            'quantity': 1,
                          });
                        });
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        dashPattern: const [6, 3],
                        color: Colors.brown,
                        strokeWidth: 1.5,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF2E9),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            '+ New Menu',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF5D2B1A),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 10,
                            offset: Offset(8, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "CART",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${getTotalPrice()} BAHT",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "DISCOUNT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "-${getDiscount()} BAHT",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "TOTAL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${getFinalPrice()} BAHT",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF5D2B1A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 10,
                          offset: Offset(4, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
