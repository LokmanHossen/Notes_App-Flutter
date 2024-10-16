// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/utils/date_time.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  String time = '';
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      // add Draer
      body: Container(
        color: Colors.grey.shade100,
        child: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(authController.user!.uid)
              .collection('notes')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final noteList = snapshot.data!.docs
                .map(
                  (e) => Note.fromMap(e),
                )
                .toList();
            return GroupedListView(
              order: GroupedListOrder.DESC,
              elements: noteList,
              groupBy: (Note note) => note.date,
              groupHeaderBuilder: (Note note) => Padding(
                padding: const EdgeInsets.all(10.0).copyWith(left: 20),
                child: Text(
                  getFormattedDate(note.date).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
              itemBuilder: (context, Note note) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      textController.text = note.text;
                      showNoteInput(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(
                          color: getLabelColor(note.date),
                          width: 10,
                        )),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 2.0,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteInput(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showNoteInput(BuildContext context, {Note? note}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Notes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            const SizedBox(
              height: 5,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Time: $time'),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isEmpty) {
                return;
              }
              if (note != null) {
                notesController.addNote(textController.text, time,
                    getDateTimestamp(DateTime.now()));
              }
            },
            child: const Text('Add Notes'),
          )
        ],
      ),
    );
  }
}
