class DocumentModel {
  final String title;
  final String uid;
  final List content;
  final DateTime createdAt;
  final String id;

  DocumentModel(
      {required this.title,
      required this.uid,
      required this.content,
      required this.createdAt,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'content': content,
      'createdAt': createdAt,
      'id': id
    };
  }
  
}
