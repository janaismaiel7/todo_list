import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/model/myUser.dart';
import 'package:todo_list/model/task.dart';

class Firebaseutiles {
  static CollectionReference<task> getTaskCollection(String uId) {
    return getUsersCollection().doc(uId)
        .collection(task.colllecationName)
        .withConverter<task>(
            fromFirestore: ((snapshot, options) =>
                task.fromfireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(task t,String uId) {
    var taskCollectionRef = getTaskCollection(uId);
    var taskDocRef = taskCollectionRef.doc();
    t.id = taskDocRef.id;
    return taskDocRef.set(t);
  }

  static Future<void> deleteTaskFromFireStore(task t,String uId) {
    return getTaskCollection(uId).doc(t.id).delete();
  }

  static Future<void> editTasktoFireStore(task t,String uId) {
    var taskCollectionRef = getTaskCollection(uId);
    return taskCollectionRef.doc(t.id).set(t);
  }

  static Future<void> updateTaskInFireStore(task t,String uId) {
    return getTaskCollection(uId).doc(t.id).update(t.toFireStore());
  }

  static CollectionReference<Myuser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(Myuser.collecationName)
        .withConverter(
            fromFirestore: ((snapshot, options) =>
                Myuser.fromFireStore(snapshot.data()!)),
            toFirestore: ((Myuser, options) => Myuser.toFireStore()));
  }

  static Future<void> addUserToFireStore(Myuser user) async {
    getUsersCollection().doc(user.id).set(user);
  }

  static Future<Myuser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}
