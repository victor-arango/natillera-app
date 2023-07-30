// ignore_for_file: non_constant_identifier_names

class Savings {
    final int id;
    final String created_at;
    final int id_user;
    final int value;

    Savings({
        required this.id,
        required this.created_at,
        required this.id_user,
        required this.value,
    });

    factory Savings.fromJson(Map<String, dynamic> json){
      return Savings(
        id: json["id"],
        created_at: json["created_at"],
        id_user: json["id_user"] is String ? int.parse(json['id_user']): json['id_user'],
        value: json["value"] is String ? int.parse(json["value"]) : json["value"],
      );
    }
      

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": created_at,
        "id_user": id_user,
        "value": value,
    };
}
