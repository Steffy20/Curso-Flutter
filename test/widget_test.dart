// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/local_task_repository.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('TaskFlow muestra la lista de tareas', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TasksViewModel(LocalTaskRepository()),
        child: const TaskFlowApp(),
      ),
    );

    expect(find.text('Mis tareas'), findsOneWidget);
  });
}