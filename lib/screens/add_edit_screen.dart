import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AddEditScreen extends StatefulWidget {
  final Note? note;

  const AddEditScreen({super.key, this.note});

  @override
  AddEditScreenState createState() => AddEditScreenState();
}

class AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final id = widget.note?.id ?? const Uuid().v4();
      final note = Note(
        id: id,
        title: _titleController.text,
        content: _contentController.text,
      );
      firestoreService.setNote(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 6,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter content' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveNote,
                icon: Icon(Icons.save),
                label: Text(isEditing ? 'Update Note' : 'Save Note'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
