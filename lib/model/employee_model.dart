import 'dart:convert';

class EmployeeModel {
    final int id;
    final String name;
    final int? managerId;
    final List<EmployeeModel> children;

    EmployeeModel({
        required this.id,
        required this.name,
        required this.managerId,
        List<EmployeeModel>? children
    }): children = children ?? [];

    EmployeeModel copyWith({
        int? id,
        String? name,
        int? managerId,
        List<EmployeeModel>? children
    }) => 
        EmployeeModel(
            id: id ?? this.id,
            name: name ?? this.name,
            managerId: managerId ?? this.managerId,
            children: children ?? this.children
        );

    factory EmployeeModel.fromRawJson(String str) => EmployeeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        name: json["name"],
        managerId: json["managerId"],
        children: json["children"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "managerId": managerId,
        "children": children
    };
}
