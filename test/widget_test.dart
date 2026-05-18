import 'package:flutter_test/flutter_test.dart';
import 'package:rofof/main.dart';
import 'package:rofof/providers/cart_provider.dart';
import 'package:rofof/providers/favorites_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      RafoufApp(
        cartProvider: CartProvider(),
        favoritesProvider: FavoritesProvider(),
      ),
    );
    expect(find.text('ROFOF BOOKS'), findsOneWidget);
  });
}
