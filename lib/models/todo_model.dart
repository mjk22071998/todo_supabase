class TodoModel {
  int? id;
  String title;
  String content;
  bool status;
  String? created_at;

  TodoModel({
    this.id,
    required this.title,
    required this.content,
    required this.status,
    this.created_at,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      status: map['status'] ?? false,
      created_at: map['created_at'] ?? '',
    );
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? content,
    bool? status,
    String? created_at,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'status': status});
    result.addAll({'created_at': created_at});

    return result;
  }
}
