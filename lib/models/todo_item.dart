import 'dart:convert';

class TodoItem {
  int? id;
  String title;
  String content;
  bool status;

  TodoItem({
    this.id,
    required this.title,
    required this.content,
    required this.status,
  });

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      content: map['description'] ?? '',
      status: map['isCompleted'] ?? false,
    );
  }

  TodoItem copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: description ?? this.content,
      status: isCompleted ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': content});
    result.addAll({'isCompleted': status});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, description: $content, isCompleted: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoItem &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ status.hashCode;
  }
}
