import 'dart:convert';

class EmployeeModel {
    final int id;
    final String name;
    final int? managerId;
    List<EmployeeModel> children;
    bool isDirectReport;

    EmployeeModel({
        required this.id,
        required this.name,
        required this.managerId,
        List<EmployeeModel>? children,
        bool? isDirectReport,
    }): children = children ?? [], isDirectReport = isDirectReport ?? false;

    EmployeeModel copyWith({
        int? id,
        String? name,
        int? managerId,
        List<EmployeeModel>? children,
        bool? isDirectReport
    }) => 
        EmployeeModel(
            id: id ?? this.id,
            name: name ?? this.name,
            managerId: managerId ?? this.managerId,
            children: children ?? this.children,
            isDirectReport: isDirectReport ?? this.isDirectReport
        );

    factory EmployeeModel.fromRawJson(String str) => EmployeeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        name: json["name"],
        managerId: json["managerId"],
        children: json["children"],
        isDirectReport: json["isDirectReport"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "managerId": managerId,
        "children": children,
        "isDirectReport": isDirectReport
    };
}
