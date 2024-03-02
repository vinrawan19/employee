import 'dart:convert';

class EmployeeModel {
    final int id;
    final String name;
    final int? managerId;

    EmployeeModel({
        required this.id,
        required this.name,
        required this.managerId,
    });

    EmployeeModel copyWith({
        int? id,
        String? name,
        int? managerId,
    }) => 
        EmployeeModel(
            id: id ?? this.id,
            name: name ?? this.name,
            managerId: managerId ?? this.managerId,
        );

    factory EmployeeModel.fromRawJson(String str) => EmployeeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        name: json["name"],
        managerId: json["managerId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "managerId": managerId,
    };
}
