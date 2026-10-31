
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

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const studentName = 'Estefanía Solórzano';
    const pendingTasks = 4;
    const courseName = 'Desarrollo de aplicaciones móviles';

    // Mensaje motivacional del reto autónomo
    const motivationalMessage =
        '¡Cada tarea completada es un paso más hacia tus metas!';

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
            // Nuevo ícono relacionado con las tareas
            const Icon(
              Icons.task_alt,
              size: 56,
              color: Colors.indigo,
            ),

            const SizedBox(height: 24),

            // Saludo personalizado
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            // Mensaje motivacional
            const Text(
              motivationalMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // Nombre del curso
            const Text(
              'Bienvenido/a a $courseName.',
            ),

            const SizedBox(height: 32),

            // Tarjeta de tareas pendientes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    const Text(
                      'Tareas pendientes: $pendingTasks',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
