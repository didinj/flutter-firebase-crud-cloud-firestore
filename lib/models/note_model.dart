class Note {
  final String id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  // Convert Note to Map for Firestore
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }

  // Create Note from Firestore Map
  factory Note.fromMap(String id, Map<String, dynamic> map) {
    return Note(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
    );
  }
}
