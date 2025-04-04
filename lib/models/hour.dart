class Hour {
  String id;
  String data;
  int minute;
  String? description;

  Hour({
    required this.id,
    required this.data,
    required this.minute,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'minute': minute,
      'description': description,
    };
  }

  Hour.fromMap(Map<String, dynamic> map) :
    id = map['id'],
    data = map['data'],
    minute = map['minute'],
    description = map['description'];


}