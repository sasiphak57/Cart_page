import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      elevation: 8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              height: 110,
              color: const Color(0xFFF04F27),
              child: Stack(
                children: [
                  // 🔶 Main Row
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🍩 Icon container
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5D2B1A),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: const Icon(Icons.local_cafe,
                              size: 56, color: Colors.white),
                        ),
                        const SizedBox(width: 12),

                        // 🧾 Title + Subtitle
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, right: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(subtitle,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white70)),
                              ],
                            ),
                          ),
                        ),
                        // 💰 Price
                        Padding(
                          padding: const EdgeInsets.only(top: 16, right: 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "$price BAHT",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // ➕➖ Quantity controls (bottom right)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(20)),
                      child: Container(
                        color: const Color(0xFF5D2B1A),
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white),
                              onPressed: onDecrement,
                              constraints:
                                  const BoxConstraints(minWidth: 0, minHeight: 0),
                              padding: EdgeInsets.symmetric(),
                              iconSize: 18,
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: onIncrement,
                              constraints:
                                  const BoxConstraints(minWidth: 0, minHeight: 0),
                              padding: EdgeInsets.zero,
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -20, // ✅ ปรับให้ล้นออกมาครึ่งเดียว
            right: -16,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF5D2B1A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.white),
                onPressed: onDelete,
                iconSize: 16,
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
