import 'package:flutter_test/flutter_test.dart';
import 'package:rofof/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RafoufApp());
    expect(find.text('RAFOUF STORE'), findsOneWidget);
  });
}
