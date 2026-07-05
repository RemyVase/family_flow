import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

/// Demo data used while the app is design-only (no backend wired yet).
/// Task names are user-visible demo content, kept in the app's language.
abstract final class MockTasks {
  static const List<Task> today = [
    Task(
      id: 't1',
      name: 'Vider le lave-vaisselle',
      moment: TaskMoment.morning,
      time: '8:00',
      recurrence: TaskRecurrence.daily,
      points: 2,
      isDone: true,
      memberId: 'lea',
    ),
    Task(
      id: 't2',
      name: 'Donner à manger au chat',
      moment: TaskMoment.morning,
      time: '8:30',
      recurrence: TaskRecurrence.twiceDaily,
      points: 1,
      isDone: true,
      memberId: 'lea',
    ),
    Task(
      id: 't3',
      name: 'Préparer le sac de sport',
      moment: TaskMoment.morning,
      time: '8:45',
      points: 1,
      memberId: 'lea',
    ),
    Task(
      id: 't4',
      name: 'Sortir les poubelles',
      moment: TaskMoment.afternoon,
      time: '17:00',
      recurrence: TaskRecurrence.weekly,
      points: 3,
      memberId: 'lea',
    ),
    Task(
      id: 't5',
      name: 'Devoirs de maths',
      moment: TaskMoment.afternoon,
      time: '18:00',
      points: 2,
      hasPhoto: true,
      memberId: 'lea',
    ),
    Task(
      id: 't6',
      name: 'Mettre la table',
      moment: TaskMoment.evening,
      time: '19:00',
      recurrence: TaskRecurrence.thriceDaily,
      points: 1,
      memberId: 'lea',
    ),
    Task(
      id: 't7',
      name: 'Ranger le salon',
      moment: TaskMoment.evening,
      time: '20:00',
      points: 2,
      memberId: 'lea',
    ),
  ];

  static const List<Task> week = [
    Task(
      id: 'w1',
      name: 'Vider le lave-vaisselle',
      moment: TaskMoment.morning,
      time: '8:00',
      recurrence: TaskRecurrence.daily,
      points: 2,
      isDone: true,
      memberId: 'lea',
    ),
    Task(
      id: 'w2',
      name: 'Nourrir le chat',
      moment: TaskMoment.morning,
      time: '8:30',
      recurrence: TaskRecurrence.twiceDaily,
      points: 1,
      isDone: true,
      memberId: 'tom',
    ),
    Task(
      id: 'w3',
      name: 'Lessive',
      moment: TaskMoment.afternoon,
      time: '15:00',
      points: 2,
      memberId: 'maman',
    ),
    Task(
      id: 'w4',
      name: 'Sortir les poubelles',
      moment: TaskMoment.afternoon,
      time: '17:00',
      recurrence: TaskRecurrence.weekly,
      points: 3,
      memberId: 'papa',
    ),
    Task(
      id: 'w5',
      name: 'Devoirs de maths',
      moment: TaskMoment.afternoon,
      time: '18:00',
      points: 2,
      memberId: 'lea',
    ),
    Task(
      id: 'w6',
      name: 'Mettre la table',
      moment: TaskMoment.evening,
      time: '19:00',
      recurrence: TaskRecurrence.thriceDaily,
      points: 1,
      memberId: 'tom',
    ),
    Task(
      id: 'w7',
      name: 'Ranger le salon',
      moment: TaskMoment.evening,
      time: '20:00',
      points: 2,
      memberId: 'maman',
    ),
  ];
}
