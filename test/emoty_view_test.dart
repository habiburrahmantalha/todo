import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/widgets/empty_view.dart';// Replace with the correct path to your EmptyView widget

Future<void> main() async {
  // Helper method to create the test widget with EasyLocalization
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget createWidgetUnderTest(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('de'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets('EmptyView displays title, description, and button', (WidgetTester tester) async {
    // Arrange
    const titleText = 'task_not_found'; // The key used in your translation file
    const descriptionText = 'add_a_task'; // The key used in your translation file
    const buttonText = 'create_task'; // The key used in your translation file

    // Act
    await tester.pumpWidget(createWidgetUnderTest(
      EmptyView(
        title: titleText.tr(), // Use the .tr() method to translate the key
        description: descriptionText.tr(),
        button: ElevatedButton(
          onPressed: () {},
          child: Text(buttonText.tr()),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    // Assert
    expect(find.text(titleText.tr()), findsOneWidget);
    expect(find.text(descriptionText.tr()), findsOneWidget);
    expect(find.text(buttonText.tr()), findsOneWidget);
  });

  testWidgets('EmptyView displays image if provided', (WidgetTester tester) async {
    // Arrange
    const titleText = 'task_not_found';
    final testImage = Image.asset('assets/images/empty.png');

    // Act
    await tester.pumpWidget(createWidgetUnderTest(
      EmptyView(
        title: titleText,
        image: testImage,
      ),
    ));

    // Assert
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(titleText.tr()), findsOneWidget);
  });

  testWidgets('EmptyView does not display description or button if not provided', (WidgetTester tester) async {
    // Arrange
    const titleText = 'task_not_found';

    // Act
    await tester.pumpWidget(createWidgetUnderTest(
      const EmptyView(
        title: titleText,
      ),
    ));

    // Assert
    expect(find.text(titleText.tr()), findsOneWidget);
    expect(find.byType(Text), findsOneWidget); // Only the title text should be found
    expect(find.byType(ElevatedButton), findsNothing); // No button should be found
  });


}
