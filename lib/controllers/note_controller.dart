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

  updateNote(String id, Note note) async {}

  deleteNote(String id) async {}

  deleteCompleted() {}
}
