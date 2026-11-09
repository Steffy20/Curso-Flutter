
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const TaskFlowApp());
}

// MODELO DE DATOS
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

// TAREAS LOCALES
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

// CONFIGURACIÓN DE RUTAS
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.tryParse(
          state.pathParameters['id'] ?? '',
        );

        if (taskId == null ||
            !demoTasks.any((task) => task.id == taskId)) {
          return const Scaffold(
            body: Center(
              child: Text('Tarea no encontrada'),
            ),
          );
        }

        return TaskDetailScreen(taskId: taskId);
      },
    ),
  ],
);

// APLICACIÓN PRINCIPAL
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

// TARJETA REUTILIZABLE
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
  });

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          task.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(task.title),
        subtitle: Text(
          '${task.priority} · ${task.description}',
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// PANTALLA DE LISTADO
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];

          return TaskCard(
            task: task,
            onTap: () => context.push('/task/${task.id}'),
          );
        },
      ),
    );
  }
}

// PANTALLA DE DETALLE
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final int taskId;

  @override
  Widget build(BuildContext context) {
    final task = demoTasks.firstWhere(
      (item) => item.id == taskId,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de tarea'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.pending_actions,
              size: 56,
              color: task.isCompleted
                  ? Colors.green
                  : Colors.indigo,
            ),

            const SizedBox(height: 24),

            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 20),

            Chip(
              label: Text('Prioridad: ${task.priority}'),
            ),

            const SizedBox(height: 12),

            Text(
              task.isCompleted
                  ? 'Estado: completada'
                  : 'Estado: pendiente',
            ),

            const SizedBox(height: 24),

            // Acción visual contextual
            Card(
              child: ListTile(
                leading: Icon(
                  task.isCompleted
                      ? Icons.verified
                      : Icons.info_outline,
                  color: task.isCompleted
                      ? Colors.green
                      : Colors.indigo,
                ),
                title: Text(
                  task.isCompleted
                      ? 'Tarea finalizada'
                      : 'Tarea por realizar',
                ),
                subtitle: Text(
                  task.isCompleted
                      ? 'Esta actividad ya fue completada.'
                      : 'Esta actividad continúa pendiente.',
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al listado'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
