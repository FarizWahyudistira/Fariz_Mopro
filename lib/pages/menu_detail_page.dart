import 'package:flutter/material.dart';
import '../data/menu_item.dart';

class MenuDetailPage extends StatefulWidget {
  const MenuDetailPage({super.key, required this.item, required this.onAdd});
  final MenuItem item;
  final ValueChanged<int> onAdd;
  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu disimpan ke favorit')),
            ),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                children: [
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(28),
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Chip(
                            avatar: const Icon(
                              Icons.star,
                              color: Color(0xFFF3A62A),
                              size: 17,
                            ),
                            label: const Text('4.9 · Favorit pelanggan'),
                            backgroundColor: Colors.white,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Menu disimpan ke favorit'),
                              ),
                            ),
                        icon: const Icon(Icons.ios_share_outlined),
                      ),
                    ],
                  ),
                  Text(
                    '${item.category}  •  Dibuat segar setiap hari',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    rupiah(item.price),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF173B63),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tentang menu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(height: 1.55, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF2F7),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.schedule, color: Color(0xFF173B63)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Disiapkan sekitar 10–15 menit\nBisa dinikmati di tempat atau dibawa pulang',
                            style: TextStyle(height: 1.5, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF2F7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _quantity++),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          widget.onAdd(_quantity);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item.name} ditambahkan ke keranjang',
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: Text(
                          'Tambah · ${rupiah(item.price * _quantity)}',
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF173B63),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
