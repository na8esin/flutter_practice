import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/todo.dart';

final todosProvider = StreamProvider.autoDispose((ref) {
  return TodosRef().documents();
});

/// The different ways to filter the list of todos
enum TodoListFilter {
  all,
  active,
  completed,
}

/// The currently active filter.
///
/// We use [StateProvider] here as there is no fancy logic behind manipulating
/// the value since it's just enum.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The number of uncompleted todos
///
/// By using [Provider], this value is cached, making it performant.\
/// Even multiple widgets try to read the number of uncompleted todos,
/// the value will be computed only once (until the todo-list changes).
///
/// This will also optimise unneeded rebuilds if the todo-list changes, but the
/// number of uncompleted todos doesn't (such as when editing a todo).
final uncompletedTodosCountProvider = FutureProvider<int>((ref) async {
  var uncompleted =
      await todosRef.query.where(TodoField.completed, isEqualTo: false).get();
  return uncompleted.docs.length;
});
