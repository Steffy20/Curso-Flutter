import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

// Configuración principal de la aplicación
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

// Modelo de datos de una tarea
class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

// Cinco tareas locales del proyecto TaskFlow
const demoTasks = [
  Task(
    id: 1,
    title: 'Revisar actividades académicas',
    description: 'Organizar las tareas pendientes de la semana',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 2,
    title: 'Estudiar Flutter y Dart',
    description: 'Practicar widgets y componentes reutilizables',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 3,
    title: 'Completar la sesión 2',
    description: 'Implementar el contador interactivo',
    priority: 'Media',
    isCompleted: true,
  ),
  Task(
    id: 4,
    title: 'Preparar evidencias',
    description: 'Capturar el funcionamiento de TaskFlow',
    priority: 'Media',
    isCompleted: false,
  ),
  Task(
    id: 5,
    title: 'Revisar y subir el proyecto',
    description: 'Verificar el código y actualizar GitHub',
    priority: 'Baja',
    isCompleted: false,
  ),
];

// Tarjeta reutilizable
class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(task.title),
        subtitle: Text('${task.priority} · ${task.description}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// Pantalla principal con lista de tareas
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(task: task);
        },
      ),
    );
  }
}
