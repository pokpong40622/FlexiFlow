import 'package:flutter_test/flutter_test.dart';
import 'package:motion_kit/app/app_settings.dart';
import 'package:motion_kit/main.dart';

void main() {
  testWidgets('renders app shell', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(settings: AppSettings()));
    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
