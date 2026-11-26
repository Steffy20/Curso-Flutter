# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Alcance de TaskFlow

Problema: necesito organizar actividades académicas y saber cuáles faltan.
Usuario objetivo: estudiante que planifica entregas semanales.

### Historias de usuario y criterios de aceptación
1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   Criterio: la lista muestra título, prioridad y estado de cada tarea.
2. Como estudiante, quiero abrir una tarea para leer su descripción.
   Criterio: al tocar una tarjeta aparece el detalle de la tarea elegida.
3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   Criterio: el formulario guarda una tarea válida y la lista la muestra.
4. Como estudiante, quiero editar una tarea para corregir sus datos.
   Criterio: los cambios guardados aparecen en lista y detalle.
5. Como estudiante, quiero eliminar una tarea terminada para limpiar la lista.
   Criterio: después de confirmar, la tarea desaparece de la lista.

### Modelo de datos
Task: id (entero único), title (texto), description (texto),
priority (Alta, Media o Baja), isCompleted (verdadero/falso),
userId (entero que identifica al usuario de prueba).

### Pantallas previstas
Lista: tarjetas de tareas y acción para crear.
Detalle: información completa y futuras acciones de editar o eliminar.
Formulario: campos de título, descripción y prioridad.

### Requisitos no funcionales
La navegación debe tener textos comprensibles.
Un id inexistente debe mostrar un mensaje en vez de cerrar la app.

### Contrato de API que necesitaremos
GET /tasks        listar tareas
GET /tasks/:id    consultar detalle
POST /tasks       crear tarea
PATCH /tasks/:id  actualizar tarea
DELETE /tasks/:id eliminar tarea

La API concreta se elegirá después. Estas rutas son requisitos, no
direcciones de un servidor ya conectado.

## API de tareas

- **URL exacta consultada:** `https://jsonplaceholder.typicode.com/todos?userId=2`
- **Parámetro `userId` elegido:** `9` (filtra únicamente las tareas pertenecientes al usuario 9 de JSONPlaceholder).
- **Campos que llegan desde la API:** `userId` (entero), `id` (entero), `title` (texto) y `completed` (booleano).
- **Valores que TaskFlow completa por defecto:** Como la API pública no envía descripción ni nivel de importancia, `Task.fromJson` asigna por defecto una descripción estándar (por ejemplo, `'Sin descripción'` o generada desde la API) y una prioridad predeterminada (`'Media'`), además de mapear el campo `completed` hacia `isCompleted`.
- **Persistencia local temporal:** Marcar o desmarcar una tarea como completada (`save`) actualiza únicamente la copia en memoria dentro de `RemoteTaskRepository`; todavía no se envían peticiones `PUT`/`PATCH` al servidor remoto, por lo que al recargar los datos desde la API vuelven a su estado original.


# TaskFlow · Gestión de Estado Asíncrono

## Arquitectura y Estado Asíncrono
- **Estado centralizado (`ChangeNotifier`):** Gestiona los estados de la petición remota (carga, éxito, vacío y error), la lista de tareas y la tarea seleccionada para el detalle.
- **Lectura reactiva (`context.watch`):** Escucha los cambios del `ChangeNotifier` en la interfaz para renderizar el indicador de carga, la lista remota, el estado vacío con **Actualizar** o el estado de error con **Reintentar**.
- **Acciones sin reconstrucción innecesaria (`context.read`):** Dispara operaciones como cargar/actualizar tareas, reintentar tras un fallo o abrir el detalle de una tarea desde eventos de usuario (`onPressed`, `onTap`).

## Comandos de Verificación
Antes de probar y subir el avance, se ejecutaron:

```bash
dart format lib
flutter analyze
flutter run


## Formulario de Nueva Tarea (`TaskFormScreen` y Ruta `/new`)

- **Ruta y navegación:** Se declaró la ruta `/new` en `appRouter` (`lib/app/taskflow_app.dart`) apuntando a `TaskFormScreen` (`lib/features/tasks/presentation/task_form_screen.dart`) y se abrió desde `TaskListScreen` mediante el `FloatingActionButton` (`context.push<TaskDraft>('/new')`)[cite: 2, 3, 4].
- **Validación y campos:** Incluye `Form` con `GlobalKey<FormState>`, controladores de texto (`TextEditingController`) para título y descripción, mensajes de validación personalizados, selector de prioridad y selector de fecha opcional con `showDatePicker` (sin exigir la fecha para guardar)[cite: 2, 5].
- **Retorno de borrador:** Al guardar con datos válidos, se devuelve un `TaskDraft` con `context.pop(draft)` y `TaskListScreen` muestra el `SnackBar` `Formulario válido: <título>` (sin afirmar creación en servidor remoto)[cite: 2, 4].

### Evidencias del formulario

1. **Errores de validación:** Se intentó guardar el formulario con campos vacíos o inválidos para comprobar los mensajes de error bajo cada campo.
   - Captura: `![Errores de validación](evidencias/07_form_errores.png)`
2. **Formulario válido:** Se completaron título, descripción, prioridad y fecha opcional con `showDatePicker` (verificando también que guarda sin fecha).
   - Captura: `![Formulario válido](evidencias/08_form_valido.png)`
3. **Mensaje de retorno:** Al confirmar el formulario válido, se regresó a `TaskListScreen` y se capturó el `SnackBar` de retorno.
   - Captura: `![Mensaje de retorno](evidencias/09_form_retorno.png)`