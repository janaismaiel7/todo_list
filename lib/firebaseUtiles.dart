import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/model/task.dart';

class Firebaseutiles {
  static CollectionReference<task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(task.colllecationName)
        .withConverter<task>(
            fromFirestore: ((snapshot, options) =>
                task.fromfireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(task t) {
    var taskCollectionRef = getTaskCollection();
    var taskDocRef = taskCollectionRef.doc();
    t.id = taskDocRef.id;
    return taskDocRef.set(t);
  }

  static Future<void> deleteTaskFromFireStore(task t) {
    return getTaskCollection().doc(t.id).delete();
  }

  static Future<void> editTasktoFireStore(task t) {
    var taskCollectionRef = getTaskCollection();
    return taskCollectionRef.doc(t.id).set(t);
  }

  static Future<void> updateTaskInFireStore(task t) {
    return getTaskCollection().doc(t.id).update(t.toFireStore());
  }
}
