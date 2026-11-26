import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskDraft {
  const TaskDraft(this.title, this.description, this.priority, {this.dueDate});

  final String title;
  final String description;
  final String priority;
  final DateTime? dueDate;
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  String _priority = 'Media';
  DateTime? _dueDate;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      helpText: 'Selecciona una fecha límite (opcional)',
    );
    if (picked == null || !mounted) return;
    setState(() => _dueDate = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final draft = TaskDraft(
      _title.text.trim(),
      _description.text.trim(),
      _priority,
      dueDate: _dueDate,
    );
    context.pop(draft);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ej. Revisar guía de Flutter',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ingresa un título para la tarea.';
                }
                if (value.trim().length < 3) {
                  return 'El título debe tener al menos 3 caracteres.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _description,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Detalles o notas de la tarea',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Agrega una breve descripción.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _priority,
              decoration: const InputDecoration(
                labelText: 'Prioridad',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Baja', child: Text('Baja')),
                DropdownMenuItem(value: 'Media', child: Text('Media')),
                DropdownMenuItem(value: 'Alta', child: Text('Alta')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _priority = value);
                }
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: Text(
                _dueDate == null
                    ? 'Fecha límite (opcional)'
                    : 'Fecha límite: ${_formatDate(_dueDate!)}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_dueDate != null)
                    IconButton(
                      tooltip: 'Quitar fecha',
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _dueDate = null),
                    ),
                  TextButton(
                    onPressed: _pickDueDate,
                    child: const Text('Elegir'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.check),
              label: const Text('Guardar borrador'),
            ),
          ],
        ),
      ),
    );
  }
}
