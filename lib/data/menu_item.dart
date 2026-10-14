import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.emoji,
    required this.color,
    this.tag,
  });
  final String name, description, category, emoji;
  final int price;
  final Color color;
  final String? tag;
}

const menuItems = <MenuItem>[
  MenuItem(
    name: 'Nasi Ayam Bakar',
    description:
        'Ayam bakar bumbu kecap, nasi hangat, lalapan segar, dan sambal dadak.',
    price: 22000,
    category: 'Makanan',
    emoji: '🍗',
    color: Color(0xFFFFE3C8),
    tag: 'Terlaris',
  ),
  MenuItem(
    name: 'Nasi Goreng Kampung',
    description:
        'Nasi goreng dengan terasi pilihan, telur mata sapi, kerupuk, dan acar.',
    price: 18000,
    category: 'Makanan',
    emoji: '🍳',
    color: Color(0xFFFFE9A9),
    tag: 'Favorit',
  ),
  MenuItem(
    name: 'Soto Ayam',
    description:
        'Kuah kuning gurih dengan suwiran ayam, soun, telur, dan koya.',
    price: 17000,
    category: 'Makanan',
    emoji: '🍲',
    color: Color(0xFFFFD9B8),
  ),
  MenuItem(
    name: 'Mie Goreng Jawa',
    description:
        'Mie goreng manis gurih dengan sayuran, telur, dan taburan bawang goreng.',
    price: 16000,
    category: 'Makanan',
    emoji: '🍜',
    color: Color(0xFFFFD9C5),
  ),
  MenuItem(
    name: 'Es Teh Manis',
    description: 'Teh melati seduh segar dengan es batu dan gula asli.',
    price: 5000,
    category: 'Minuman',
    emoji: '🧋',
    color: Color(0xFFD5EFE3),
    tag: 'Segar',
  ),
  MenuItem(
    name: 'Es Jeruk',
    description: 'Jeruk peras pilihan, manis dan menyegarkan.',
    price: 8000,
    category: 'Minuman',
    emoji: '🍊',
    color: Color(0xFFFFE7B1),
  ),
  MenuItem(
    name: 'Pisang Goreng',
    description:
        'Pisang kepok matang dengan balutan tepung renyah, disajikan hangat.',
    price: 10000,
    category: 'Camilan',
    emoji: '🍌',
    color: Color(0xFFFFE88F),
  ),
];

String rupiah(int amount) =>
    'Rp${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
