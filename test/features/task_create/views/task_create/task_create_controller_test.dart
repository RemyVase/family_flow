import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_controller.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

void main() {
  group('TaskCreateController', () {
    test('should not allow creation while the name is empty', () {
      final controller = TaskCreateController();

      expect(controller.canCreate, isFalse);

      controller.setName('  ');
      expect(controller.canCreate, isFalse);

      controller.setName('Sortir les poubelles');
      expect(controller.canCreate, isTrue);
    });

    test('should clamp points between min and max', () {
      final controller = TaskCreateController();

      controller.decrementPoints();
      expect(controller.points, TaskCreateController.minPoints);
      expect(controller.canDecrementPoints, isFalse);

      for (var i = 0; i < 20; i++) {
        controller.incrementPoints();
      }
      expect(controller.points, TaskCreateController.maxPoints);
      expect(controller.canIncrementPoints, isFalse);
    });

    test('should update selections and notify listeners', () {
      final controller = TaskCreateController();
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.selectMember('tom');
      controller.selectRecurrence(TaskRecurrence.daily);
      controller.selectMoment(TaskMoment.morning);

      expect(controller.memberId, 'tom');
      expect(controller.recurrence, TaskRecurrence.daily);
      expect(controller.moment, TaskMoment.morning);
      expect(notifications, 3);
    });
  });
}
