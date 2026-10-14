import 'package:flutter/material.dart';
import '../data/menu_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.cart});
  final Map<MenuItem, int> cart;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _name = TextEditingController();
  final _note = TextEditingController();
  String _fulfillment = 'Bawa pulang';
  String _payment = 'Bayar di kasir';
  int get _subtotal =>
      widget.cart.entries.fold(0, (a, e) => a + e.key.price * e.value);
  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  void _submit() {
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama pemesan perlu diisi dulu.')),
      );
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          size: 52,
          color: Color(0xFF4C9A68),
        ),
        title: const Text('Pesanan diterima!'),
        content: Text(
          'Terima kasih, ${_name.text.trim()}. Pesananmu sedang disiapkan Bu Sari.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Kembali ke menu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Keranjang & checkout',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    body: SafeArea(
      child: widget.cart.isEmpty
          ? const Center(child: Text('Keranjang masih kosong.'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Pesanan kamu',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.cart.length} menu',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...widget.cart.entries.map(
                        (entry) => Card(
                          elevation: 0,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: entry.key.color,
                              child: Text(entry.key.emoji),
                            ),
                            title: Text(
                              entry.key.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${entry.value} × ${rupiah(entry.key.price)}',
                            ),
                            trailing: Text(
                              rupiah(entry.value * entry.key.price),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB94E32),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Informasi pemesan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _name,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nama pemesan',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _fulfillment,
                        decoration: const InputDecoration(
                          labelText: 'Cara menikmati',
                          prefixIcon: Icon(Icons.storefront_outlined),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Bawa pulang',
                            child: Text('Bawa pulang'),
                          ),
                          DropdownMenuItem(
                            value: 'Makan di tempat',
                            child: Text('Makan di tempat'),
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => _fulfillment = v ?? 'Bawa pulang'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _note,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Catatan untuk dapur (opsional)',
                          prefixIcon: Icon(Icons.notes),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal'),
                                Text(rupiah(_subtotal)),
                              ],
                            ),
                            const SizedBox(height: 9),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Biaya layanan'), Text('Gratis')],
                            ),
                            const Divider(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total pembayaran',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  rupiah(_subtotal),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xFFB94E32),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _payment,
                        decoration: const InputDecoration(
                          labelText: 'Metode pembayaran',
                          prefixIcon: Icon(Icons.payments_outlined),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Bayar di kasir',
                            child: Text('Bayar langsung di kasir'),
                          ),
                          DropdownMenuItem(
                            value: 'QRIS',
                            child: Text('QRIS di kasir'),
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => _payment = v ?? 'Bayar di kasir'),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFB94E32),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Konfirmasi pesanan · ${rupiah(_subtotal)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ),
  );
}
