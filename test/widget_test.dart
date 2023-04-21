import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter/colors.dart';
import 'package:test_task_flutter/random_number_generator.dart';
import 'package:test_task_flutter/yellow_screen.dart';

void main() {
  group('YellowScreen', ()
  {
    testWidgets(
      'должна отображаться кнопка “случайное число”, фон экрана желтый, а также должна отображаться кнопка “назад”',
        (WidgetTester tester) async {
          final yellowScreen = YellowScreen(
              generator: RandomNumberGeneratorImpl());
          await tester.pumpWidget(MaterialApp(home: yellowScreen));

          expect(find.text('Случайное число'), findsOneWidget);

          final yellowContainerFinder = find.byWidgetPredicate((widget) => widget is Container && widget.color == yellowColor);
          expect(yellowContainerFinder, findsOneWidget);

          expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        });

    testWidgets(
      'Проверяем, что при тапе по кнопке число от 0 до 49 отображается синим цветом',
        (WidgetTester tester) async {
          final yellowScreen = YellowScreen(
              generator: RandomNumberGeneratorImpl());
          await tester.pumpWidget(MaterialApp(home: yellowScreen));

          await tester.tap(find.text('Случайное число'));
          await tester.pumpAndSettle();

          final numberTextFinder = find.byWidgetPredicate((widget) => widget is Text && int.tryParse(widget.data!) != null);
          final number = int.parse((numberTextFinder.evaluate().single.widget as Text).data!);

          if (number >= 0 && number < 50) {
            expect((numberTextFinder.evaluate().single.widget as Text).style!.color, Colors.blue);
          }
          else {
            expect((numberTextFinder.evaluate().single.widget as Text).style!.color, Colors.black);
          }
        });
  });
}
