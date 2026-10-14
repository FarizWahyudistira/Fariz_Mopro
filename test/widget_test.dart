import 'package:flutter_test/flutter_test.dart';
import 'package:app1/main.dart';

void main() {
  testWidgets('Kantin Bu Sari menampilkan katalog menu', (tester) async {
    await tester.pumpWidget(const KantinApp());

    expect(find.text('Kantin Bu Sari'), findsOneWidget);
    expect(find.text('Menu hari ini'), findsOneWidget);
    expect(find.text('Nasi Ayam Bakar'), findsOneWidget);
  });
}
