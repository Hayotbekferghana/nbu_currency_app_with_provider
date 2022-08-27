const String userTable = "cached_user";

class CachedUsersFields {
  static final List<String> values = [
    /// Add all fields
    id, userName, age, count
  ];
  static const String id = "_id";
  static const String userName = "user_name";
  static const String age = "age";
  static const String count = "count";
}

class CachedUser {
  final int? id;
  final int count;
  final int age;
  final String userName;

  CachedUser(
      {this.id,
      required this.age,
      required this.userName,
      required this.count});

  CachedUser copyWith({
    int? id,
    int? age,
    int? count,
    String? userName,
  }) =>
      CachedUser(
          id: id ?? this.id,
          userName: userName ?? this.userName,
          age: age ?? this.age,
          count: count ?? this.count);

  static CachedUser fromJson(Map<String, Object?> json) => CachedUser(
        id: json[CachedUsersFields.id] as int?,
        userName: json[CachedUsersFields.userName] as String,
        age: json[CachedUsersFields.age] as int,
        count: json[CachedUsersFields.count] as int,
      );

  Map<String, Object?> toJson() => {
        CachedUsersFields.id: id,
        CachedUsersFields.userName: userName,
        CachedUsersFields.age: age,
        CachedUsersFields.count: count
      };

  @override
  String toString() =>
      '''              
         id: $id, 
         user_name $userName, 
         age $age,
         count:  $count
         ''';
}
