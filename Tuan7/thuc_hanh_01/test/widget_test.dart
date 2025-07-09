import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thuc_hanh_01/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Dùng màu mặc định để test
    await tester.pumpWidget(MyApp(initialColor: Colors.blue));

    // Do not forget to delay for initial rendering
    await tester.pumpAndSettle();

    // Verify counter starts at 0 (nếu bạn có widget hiển thị số '0')
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Giả sử có nút '+' để tăng counter
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
