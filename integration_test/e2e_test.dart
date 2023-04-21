import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter/colors.dart';
import 'package:test_task_flutter/home_screen.dart';
import 'package:test_task_flutter/main.dart' as app;

void main() {
  
  testWidgets('E2E test', (WidgetTester tester) async{
    //  setup
    app.main();
    await tester.pumpAndSettle();

    //1) тапнуть на кнопку “зеленый”
    await tester.tap(find.text('зеленый'));
    await tester.pumpAndSettle();
    //проверяем
    final container = tester.widget<Container>(find.byType(Container));
    expect((container.child as Text).style!.color, Colors.white);
    expect((container.child as Text).data, "Зеленый экран");
    expect(container.color, equals(greenColor));

    //2) тапнуть кнопку назад
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    //проверяем стартовый экран
    expect(find.text('Стартовый экран'), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);

    //3) тапнуть на кнопку “желтый”
    await tester.tap(find.text('желтый'));
    await tester.pumpAndSettle();
    //проверяем
    expect(find.text('Случайное число'), findsOneWidget);
    final textFinder = find.byWidgetPredicate((widget) => widget is Text && int.tryParse(widget.data!) != null);
    expect(textFinder, findsNothing);

    //4) тапнуть кнопку “случайное число”
    await tester.tap(find.text('Случайное число'));
    await tester.pumpAndSettle();
    //проверяем
    final numberTextFinder = find.byWidgetPredicate((widget) => widget is Text && int.tryParse(widget.data!) != null);
    final number = int.parse((numberTextFinder.evaluate().single.widget as Text).data!);
    expect(number, greaterThanOrEqualTo(0));
    expect(number, lessThan(100));

    //5) тапнуть кнопку назад
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    //проверяем стартовый экран
    expect(find.text('Стартовый экран'), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);

  });
}
