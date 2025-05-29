import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/note_model.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Note>>(
          stream: firestoreService.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No notes found.'));
            }

            final notes = snapshot.data!;

            return ListView.separated(
              itemCount: notes.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => firestoreService.deleteNote(note.id),
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/add-edit',
                      arguments: note,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-edit'),
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
    );
  }
}
