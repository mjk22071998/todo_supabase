import 'dart:convert';

class TodoItem {
  int? id;
  String title;
  String content;
  bool status;
  String? created_at;

  TodoItem({
    this.id,
    required this.title,
    required this.content,
    required this.status,
    this.created_at,
  });

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      status: map['status'] ?? false,
      created_at: map['created_at'] ?? '',
    );
  }

  TodoItem copyWith({
    int? id,
    String? title,
    String? content,
    bool? status,
    String? created_at,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'status': status});
    result.addAll({'created_at': created_at});
  
    return result;
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, content: $content, status: $status, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TodoItem &&
      other.id == id &&
      other.title == title &&
      other.content == content &&
      other.status == status &&
      other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      status.hashCode ^
      created_at.hashCode;
  }
}
