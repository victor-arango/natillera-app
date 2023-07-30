class Users {
    final int? id;
    final String name;
    final String apellido;
    final int saving;

    Users({
         this.id,
        required this.name,
        required this.apellido,
        required this.saving,
    });

    factory Users.fromJson(Map<String, dynamic> json){
      return Users(
        id: json["id"],
        name: json["name"],
        apellido: json["apellido"],
        saving: json["saving"],
      );
    }
      

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "apellido": apellido,
        "saving": saving,
    };
}
