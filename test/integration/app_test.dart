import 'package:ai_color_palette_finder/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on the home screen', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.text('Choose Image'), findsOneWidget);
  });
}
