import 'package:flutter_test/flutter_test.dart';
import 'package:task2/main.dart';

void main() {
  testWidgets('App renders Rofof Book home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RofofApp());

    // Verify that the home screen renders correctly by looking for the title text.
    expect(find.text('Rofof Book'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
