import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:book_club/main.dart';
import 'package:book_club/widgets/book_image.dart';

void main() {
  testWidgets('list, sort, detail and back', (tester) async {
    await tester.pumpWidget(const BookClubApp());
    await tester.pumpAndSettle();

    expect(find.text('Book Club Home'), findsOneWidget);
    expect(find.text('Sort by'), findsOneWidget);

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();
    expect(find.byType(BookImage), findsWidgets);

    await tester.tap(find.byType(BookImage).first);
    await tester.pumpAndSettle();
    expect(find.text('Book Detail'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Book Club Home'), findsOneWidget);
  });
}
