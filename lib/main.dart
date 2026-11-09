
import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Widget con estado
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Estefanía Solórzano';
  final String courseName = 'Desarrollo de aplicaciones móviles';

  final String motivationalMessage =
      '¡Cada tarea completada es un paso más hacia tus metas!';

  // Variable que cambiará durante la ejecución
  int pendingTasks = 3;

  // Disminuir tareas pendientes
  void completeTask() {
    if (pendingTasks == 0) return;

    setState(() {
      pendingTasks--;
    });
  }

  // Aumentar tareas pendientes
  void addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.task_alt,
              size: 56,
              color: Colors.indigo,
            ),

            const SizedBox(height: 24),

            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            Text(
              motivationalMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            Text('Bienvenido/a a $courseName.'),

            const SizedBox(height: 32),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text(
                      'Tareas pendientes: $pendingTasks',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botones para actualizar el estado
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: completeTask,
                  icon: const Icon(Icons.remove),
                  label: const Text('Completar'),
                ),

                const SizedBox(width: 12),

                ElevatedButton.icon(
                  onPressed: addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
