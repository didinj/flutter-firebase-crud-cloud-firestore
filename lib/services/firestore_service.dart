import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirestoreService {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes');

  // Create or update note
  Future<void> setNote(Note note) {
    return notesCollection.doc(note.id).set(note.toMap());
  }

  // Get notes as a stream
  Stream<List<Note>> getNotes() {
    return notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Delete a note
  Future<void> deleteNote(String id) {
    return notesCollection.doc(id).delete();
  }
}
