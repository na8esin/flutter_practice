import 'package:firestore_ref/firestore_ref.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  factory Todo({
    //@required String id,
    @required String title,
    @required @TimestampConverter() DateTime testDay,
    String description,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _Todo;
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

class TodoField {
  static const title = 'title';
  static const testDay = 'testDay';
  static const description = 'description';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

final todosRef = TodosRef();

class TodosRef extends CollectionRef<Todo, TodoDoc, TodoRef> {
  TodosRef() : super(FirebaseFirestore.instance.collection('todos'));

  @override
  Map<String, dynamic> encode(Todo data) =>
      replacingTimestamp(json: data.toJson());

  @override
  TodoDoc decode(DocumentSnapshot snapshot, TodoRef docRef) {
    assert(docRef != null);
    return TodoDoc(
      docRef,
      Todo.fromJson(snapshot.data()),
    );
  }

  @override
  TodoRef docRef(DocumentReference ref) => TodoRef(
        ref: ref,
        todosRef: this,
      );
}

class TodoRef extends DocumentRef<Todo, TodoDoc> {
  const TodoRef({
    @required DocumentReference ref,
    @required this.todosRef,
  }) : super(
          ref: ref,
          collectionRef: todosRef,
        );

  final TodosRef todosRef;
}

class TodoDoc extends Document<Todo> {
  const TodoDoc(
    this.todoRef,
    Todo entity,
  ) : super(todoRef, entity);

  final TodoRef todoRef;
}
