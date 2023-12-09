import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';

void main() {
  testWidgets('Reservation Form Widget Test', (WidgetTester tester) async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized()
            as TestWidgetsFlutterBinding;

    binding.window.physicalSizeTestValue = Size(360, 640);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(MaterialApp(
      home: ReservationForm(
        date: '2023-12-01',
        time: '08:00',
        id: '12345',
      ),
    ));

    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Create Reservation'), findsNothing);
    expect(find.text('Edit Reservation'), findsOneWidget);
    expect(find.text('Select desired date'), findsOneWidget);
    expect(find.text('Select desired time'), findsOneWidget);
    expect(find.text('Masukkan nomor BPJS Anda'), findsOneWidget);

    // Testing form interaction (change date)
    await tester.tap(find.byIcon(Icons.date_range_rounded));
    
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Replace 'XX:XX' with a specific time you'd expect after selecting
    await tester.tap(find.byIcon(Icons.access_time));
    await tester.pumpAndSettle();
    await tester.tap(find.text('sunday'));
    await tester.pumpAndSettle();

    // Testing form submission
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // You can add more tests for different scenarios and interactions here
  });
}
