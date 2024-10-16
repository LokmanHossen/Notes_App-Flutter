import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/utils/constants.dart';

class NotesController extends GetxController {
  static NotesController instance = Get.find();
  addNote(String noteText, String time, int date) async {
    try {
      final ref = firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('notes')
          .doc();
      final note = Note(
          id: ref.id, text: noteText, isDone: false, time: time, date: date);
      await ref.set(note.toMap());
    } catch (e) {
      debugPrint('Something went wrong(Add): $e');
    }
  }

  updateNote(String id, Note note) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('notes')
          .doc(id)
          .update(note.toMap());
    } catch (e) {
      debugPrint('Something went wrong(Update): $e');
    }
  }

  deleteNote(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('notes')
          .doc(id)
          .delete();
    } catch (e) {
      debugPrint('Something went wrong(Delete): $e');
    }
  }

  deleteCompleted() {
    try {
      WriteBatch batch = firestore.batch();
      return firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('notes')
          .where('isDone', isEqualTo: true)
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
        return batch.commit();
      });
    } catch (e) {
      debugPrint('Something went wrong(Batch Delete): $e');
    }
  }
}
