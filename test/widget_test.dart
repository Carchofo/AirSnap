import 'package:flutter_test/flutter_test.dart';

import 'package:airsnap/main.dart';

void main() {
  testWidgets('AirSnapApp builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const AirSnapApp());
    expect(find.byType(AirSnapApp), findsOneWidget);
  });
}
