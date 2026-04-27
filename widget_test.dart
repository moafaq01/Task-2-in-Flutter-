import 'package:flutter_test/flutter_test.dart';
import 'package:task/main.dart';

void main() {
  testWidgets('App renders login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PremiumCoffeeApp());

    // Verify that the login screen renders correctly by looking for the title text.
    expect(find.text('أهلاً بعودتك'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);
  });
}
